🚴‍♂️ Projet Vélib' Paris : Planificateur de Route en Temps Réel
Ce projet est une application web minimaliste et gratuite, développée avec Python et Flask, qui permet aux utilisateurs de visualiser en temps réel l'état des stations Vélib' à Paris et de planifier des itinéraires cyclables précis.

✨ Fonctionnalités
Visualisation en Temps Réel : Les marqueurs de stations sont colorés selon la disponibilité des vélos (Vert pour disponible, Rouge pour vide).

Planification d'Itinéraire (Routage Cyclable) : Utilisation de l'API OSRM (Open Source Routing Machine) pour tracer des chemins précis qui suivent les routes cyclables réelles.

Informations de Navigation : Affiche la distance totale, la durée estimée du trajet, et des instructions détaillées étape par étape.

Interface Simple : Une barre latérale fixe gère la sélection des stations de départ et d'arrivée.

🛠️ Configuration du Projet
Pré-requis
Pour exécuter ce projet localement, vous devez avoir :

Python 3.8+

MongoDB installé et en cours d'exécution.

Accès aux données Vélib' (la base de données est configurée pour velib_Paris).

1. Installation des Dépendances
Installez toutes les bibliothèques requises :

Bash

# Installe les dépendances requises
pip install flask pymongo python-dotenv folium geopy requests polyline
2. Configuration des Accès
Ce projet utilise le service de routage public OSRM (gratuit, sans clé API).

Créez un fichier nommé .env (au même niveau que Carte_Velib.py).

Ajoutez votre URI de connexion MongoDB.

Extrait de code

# Fichier .env (NE PAS PUBLIER SUR GITHUB)
MONGO_URI="mongodb://admin:admin@localhost:27017/?authSource=admin"

# Les clés de routage (ORS_API_KEY) sont ignorées, car nous utilisons OSRM gratuit.
▶️ Comment Lancer l'Application
Assurez-vous que votre serveur MongoDB est en cours d'exécution.

Dans votre terminal (avec l'environnement virtuel activé), lancez l'application Flask en utilisant le nom de votre fichier :

Bash

python Carte_Velib.py
Ouvrez votre navigateur et accédez à : http://127.0.0.1:5000/

🧑‍💻 Structure du Code
Le cœur de l'application est contenu dans Carte_Velib.py et est structuré autour des fonctions clés de routage et de rendu Flask.

get_osrm_route(start, end) : Contacte le serveur OSRM public pour le routage cyclable. Cette fonction retourne le tracé, la distance, la durée et les instructions détaillées.

generate_velib_map(...) : Construit la carte Folium, place les marqueurs (colorés selon la disponibilité), et trace le chemin routier en utilisant les données de get_osrm_route.

index() : La fonction principale de routage Flask qui gère les requêtes HTTP, maintient l'état du formulaire (sélections de stations), et rend le HTML_TEMPLATE.