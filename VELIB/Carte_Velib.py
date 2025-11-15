import folium
import requests
import json
import dotenv, os
from pymongo import MongoClient
from geopy.distance import distance
from flask import Flask, render_template_string, request
import math
from polyline import decode 

# --- Configuration et Connexion MongoDB ---
dotenv.load_dotenv()
client = MongoClient("mongodb://admin:admin@localhost:27017/?authSource=admin")
db = client["velib_Paris"]
collection = db["Paris"]

# Clé API pour le routage ORS (Non utilisée, mais laissée pour la configuration .env)
ORS_API_KEY = os.getenv("ORS_API_KEY")

# --- Configuration Flask ---
app = Flask(__name__)
MARKER_RADIUS = 8 

# --- TEMPLATE HTML (Final) ---
HTML_TEMPLATE = """
<!DOCTYPE html>
<html>
<head>
    <title>Vélib' Map - Route Planner</title>
    <style>
        /* CSS pour fixer la barre de contrôle à gauche */
        #controls {
            position: fixed;
            top: 20px;
            left: 20px;
            z-index: 1000;
            background-color: rgba(255, 255, 255, 0.9);
            padding: 15px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            max-width: 350px;
        }
        select, button {
            width: 100%;
            padding: 8px;
            margin-bottom: 10px;
            box-sizing: border-box;
        }
        #end_station_div {
            margin-top: 15px;
            border-top: 1px solid #ccc;
            padding-top: 15px;
        }
        /* Style pour les instructions déroulantes */
        #instructions {
            margin-top: 20px;
            padding: 10px 0;
            border-top: 1px solid #ddd;
            max-height: 250px;
            overflow-y: auto;
        }
        .instruction-step {
            font-size: 0.9em;
            margin-bottom: 5px;
            border-bottom: 1px dotted #eee;
            padding-bottom: 3px;
        }
        .summary {
            font-weight: bold;
            color: #0056b3;
            margin-bottom: 10px;
            border-bottom: 2px solid #0056b3;
            padding-bottom: 5px;
        }
    </style>
</head>
<body>
    <div id="controls">
        <h1>🚴 Vélib' Route Planner</h1>

        <form method="POST">
            <label for="start_station">Station :</label>
            <select id="start_station" name="start_station"> 
                <option value="">-- Choisir le départ --</option>
                {% for station in all_station_names %}
                    <option value="{{ station }}" {% if station == start_station_name %}selected{% endif %}>{{ station }}</option>
                {% endfor %}
            </select>
            
            <div style="display: flex; align-items: center; justify-content: space-between; margin-bottom: 10px;">
                <label for="is_routing" style="width: auto;">Effectuer un trajet ?</label>
                <input type="checkbox" id="is_routing" name="is_routing" value="true" 
                       {% if is_routing %}checked{% endif %} 
                       style="width: 20px;" onchange="toggleEndStation()">
            </div>

            <div id="end_station_div" style="{% if not is_routing %}display: none;{% endif %}">
                <label for="end_station">Station d'arrivée  :</label>
                <select id="end_station" name="end_station">
                    <option value="">-- Choisir l'arrivée --</option>
                    {% for station in all_station_names %}
                        <option value="{{ station }}" {% if station == end_station_name %}selected{% endif %}>{{ station }}</option>
                    {% endfor %}
                </select>
            </div>
            
            <button type="submit" name="action" value="update_map">Mettre à jour la carte / Tracer la route</button>

            {% if instructions %}
            <div class="summary">
                ⏱️ Durée estimée : {{ route_duration_str }}<br>
                📏 Distance totale : {{ route_distance_km }} km
            </div>
            <h2>Instructions</h2>
            <div id="instructions">
                {% for step in instructions %}
                    <div class="instruction-step">{{ loop.index }}. {{ step }}</div>
                {% endfor %}
            </div>
            {% endif %}

        </form>
    </div>
    
    {{ velib_map_html | safe }}
    
    <div style="height: 100vh;"></div>

    <script>
        function toggleEndStation() {
            var routingChecked = document.getElementById('is_routing').checked;
            var endStationDiv = document.getElementById('end_station_div');
            
            if (routingChecked) {
                endStationDiv.style.display = 'block';
            } else {
                endStationDiv.style.display = 'none';
            }
            // IMPORTANT : Aucune soumission automatique ici, l'utilisateur doit utiliser le bouton.
        }
        
        document.addEventListener('DOMContentLoaded', function() {
            toggleEndStation(); 
        });
    </script>
</body>
</html>
"""

def format_duration(seconds):
    """Convertit les secondes en format 'X min' ou 'Y h Z min'."""
    if seconds is None:
        return ""
    
    minutes = round(seconds / 60)
    
    if minutes < 60:
        return f"{minutes} min"
    
    hours = math.floor(minutes / 60)
    remaining_minutes = minutes % 60
    
    return f"{hours} h {remaining_minutes} min"

def get_all_stations():
    """Récupère toutes les stations une seule fois."""
    return list(collection.find())

def get_station_coords(station_name, all_stations):
    """Récupère les coordonnées d'une station par son nom et d'autres infos."""
    station = next((s for s in all_stations if s.get('name') == station_name), None)
    if station:
        return {
            'lat': station["coordonnees_geo"]["lat"], 
            'lon': station["coordonnees_geo"]["lon"],
            'bikes': station.get("numbikesavailable", 0),
            'docks': station.get("numdocksavailable", 0)
        }
    return None

def get_osrm_route(start_coords, end_coords):
    """
    Appelle le serveur OSRM public pour obtenir un tracé de route cyclable, la distance, la durée et les instructions.
    """
    # Format OSRM: longitude,latitude;longitude,latitude
    coords_str = f"{start_coords['lon']},{start_coords['lat']};{end_coords['lon']},{end_coords['lat']}"
    
    # Endpoint OSRM pour le vélo (public et gratuit)
    url = f"http://router.project-osrm.org/route/v1/bike/{coords_str}?geometries=polyline&steps=true"
    
    try:
        response = requests.get(url, timeout=10)
        data = response.json()
        
        if data['code'] == 'Ok' and data['routes']:
            
            route_data = data['routes'][0]
            distance_km = route_data['distance'] / 1000
            duration_sec = route_data['duration'] # Temps en secondes
            encoded_path = route_data['geometry']
            
            # Décodage de la polyline
            route_coords = decode(encoded_path) 

            # Extraction des instructions de manœuvre (CORRIGÉ : Construction détaillée)
            instructions = []
            if 'legs' in route_data and route_data['legs']:
                for leg in route_data['legs']:
                    if 'steps' in leg:
                        for step in leg['steps']:
                            # Récupération sécurisée des données
                            instruction = step['maneuver'].get('instruction', 'Continuer tout droit.')
                            step_name = step.get('name', 'sur la route.')
                            step_distance_m = step.get('distance', 0)
                            
                            # Formatage de la distance pour l'affichage (arrondi)
                            if step_distance_m >= 1000:
                                distance_str = f"{step_distance_m / 1000:,.1f} km"
                            else:
                                distance_str = f"{int(step_distance_m)} m"

                            # Construction de la phrase complète
                            full_instruction = f"{instruction} sur {step_name} pendant {distance_str}."
                            instructions.append(full_instruction)
                            
            return route_coords, distance_km, duration_sec, instructions
        
        else:
            print(f"Erreur OSRM: {data.get('code', 'Erreur inconnue')}. Message: {data.get('message', 'Pas de route trouvée.')}")
            return None, None, None, None
            
    except requests.exceptions.RequestException as e:
        print(f"Erreur de connexion OSRM: {e}")
        return None, None, None, None
    except Exception as e:
        print(f"Erreur de traitement OSRM: {e}")
        return None, None, None, None


def generate_velib_map(all_stations, start_station_name=None, end_station_name=None, is_routing=False):
    """Génère la carte Folium avec toutes les stations et le chemin réel (si demandé)."""

    user_lat, user_lon = 48.8566, 2.3522 # Paris Centre par défaut
    zoom = 12
    
    start_info = get_station_coords(start_station_name, all_stations)
    end_info = get_station_coords(end_station_name, all_stations)
    
    route_coords, route_distance_km, route_duration_sec, instructions = None, None, None, None
    
    # Déterminer le centre de la carte
    if start_info:
        user_lat, user_lon = start_info['lat'], start_info['lon']
        zoom = 15
    elif end_info:
        user_lat, user_lon = end_info['lat'], end_info['lon']
        zoom = 15

    map_paris = folium.Map(location=[user_lat, user_lon], zoom_start=zoom)
    
    # 1. Traçage du chemin réel (si demandé et possible)
    if is_routing and start_info and end_info and start_station_name != end_station_name:
        
        # --- APPEL DE LA FONCTION OSRM (GRATUIT) ---
        route_coords, route_distance_km, route_duration_sec, instructions = get_osrm_route(start_info, end_info)
        
        if route_coords:
            folium.PolyLine(
                route_coords,
                color="darkblue",
                weight=5,
                opacity=0.8,
                popup=f"Distance: {route_distance_km:,.2f} km | Durée: {format_duration(route_duration_sec)}"
            ).add_to(map_paris)
        else:
            # Si le routage échoue, on affiche une ligne droite pour donner une idée
            line_distance = distance((start_info['lat'], start_info['lon']), (end_info['lat'], end_info['lon'])).meters
            folium.PolyLine(
                [[start_info['lat'], start_info['lon']], [end_info['lat'], end_info['lon']]],
                color="gray",
                weight=2,
                opacity=0.5,
                dash_array="5, 10",
                popup=f"Erreur routage. Distance ligne droite: {line_distance:,.0f} m"
            ).add_to(map_paris)


    # 2. Marqueurs Spéciaux pour le départ et l'arrivée
    marked_stations = set()

    # DÉPART
    if start_info:
        marked_stations.add(start_station_name)
        
        start_color = "red" if start_info.get('bikes', 0) == 0 else "green" 
        
        popup_text = (
            f"<b>DÉPART: {start_station_name}</b><br>"
            f"🚲 Vélos dispo: {start_info.get('bikes')}<br>"
            f"🅿️ Places libres: {start_info.get('docks')}"
        )
        if route_distance_km:
             popup_text += f"<br>Route: {route_distance_km:,.2f} km ({format_duration(route_duration_sec)})"
        
        folium.Marker(
            [start_info['lat'], start_info['lon']],
            popup=popup_text,
            icon=folium.Icon(color=start_color, icon="play")
        ).add_to(map_paris)

    # ARRIVÉE
    if end_info and start_station_name != end_station_name and is_routing:
        marked_stations.add(end_station_name)
        
        end_color = "darkred" if end_info.get('docks', 0) > 0 else "black"
        
        popup_text = (
            f"<b>ARRIVÉE: {end_station_name}</b><br>"
            f"🚲 Vélos dispo: {end_info.get('bikes')}<br>"
            f"🅿️ Places libres: {end_info.get('docks')}"
        )
        
        folium.Marker(
            [end_info['lat'], end_info['lon']],
            popup=popup_text,
            icon=folium.Icon(color=end_color, icon="flag")
        ).add_to(map_paris)

    # 3. Marqueurs de TOUTES les stations (standard)
    for s in all_stations:
        name = s.get("name")
        if name in marked_stations or name is None:
            continue

        try:
            lat = s["coordonnees_geo"]["lat"]
            lon = s["coordonnees_geo"]["lon"]
            bikes = s.get("numbikesavailable", 0)
            docks = s.get("numdocksavailable", 0) 

            if bikes >= 10: color = "green"
            elif 3 <= bikes < 10: color = "orange"
            else: color = "red"
            
            popup_text = (
                f"<b>{name}</b><br>"
                f"🚲 Vélos dispo: {bikes}<br>"
                f"🅿️ Places libres: {docks}"
            )

            folium.CircleMarker(
                [lat, lon],
                radius=MARKER_RADIUS, 
                popup=popup_text,
                tooltip=f"{name} ({bikes} vélos / {docks} places)",
                color=color, fill=True, fill_color=color, fill_opacity=0.6
            ).add_to(map_paris)

        except Exception:
            continue
            
    # La correction de l'AttributeError est confirmée ici
    return map_paris._repr_html_(), instructions, route_distance_km, format_duration(route_duration_sec)


@app.route('/', methods=['GET', 'POST'])
def index():
    # Assurez-vous que la librairie polyline est installée pour cette fonction
    try:
        from polyline import decode 
    except ImportError:
        return "Erreur: La librairie 'polyline' est nécessaire pour le routage OSRM. Veuillez l'installer (pip install polyline).", 500


    all_stations = get_all_stations()
    all_station_names = sorted([s.get('name') for s in all_stations if s.get('name')])
    
    start_station_name = request.form.get('start_station', '')
    end_station_name = request.form.get('end_station', '')
    is_routing = request.form.get('is_routing', 'false') == 'true' 

    # Logique pour s'assurer que l'état de la carte est cohérent
    
    # 1. Si pas de station de départ, on ne peut rien faire.
    if not start_station_name:
        is_routing = False
        end_station_name = ''

    # 2. Si le routage est désactivé (checkbox non cochée), on efface l'arrivée pour réinitialiser la liste
    if not is_routing:
        end_station_name = ''
    
    # 3. Si le routage est coché mais l'arrivée est vide, on le désactive pour éviter l'appel OSRM
    if is_routing and not end_station_name:
         is_routing = False

    # Génération de la carte et récupération des instructions
    velib_map_html, instructions, route_distance_km, route_duration_str = generate_velib_map(
        all_stations, start_station_name, end_station_name, is_routing
    )

    # Rendu final
    return render_template_string(
        HTML_TEMPLATE,
        velib_map_html=velib_map_html,
        all_station_names=all_station_names,
        start_station_name=start_station_name,
        end_station_name=end_station_name,
        is_routing=is_routing,
        instructions=instructions,
        route_distance_km=f"{route_distance_km:,.2f}" if route_distance_km is not None else None,
        route_duration_str=route_duration_str
    )

if __name__ == '__main__':
    # Le serveur Flask sera accessible à http://127.0.0.1:5000/
    app.run(debug=True)