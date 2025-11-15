# 🚴‍♂️ Projet Vélib' Paris : Planificateur de Route en Temps Réel

Ce projet est une application web minimaliste et gratuite, développée avec **Python** et **Flask**, qui permet aux utilisateurs de visualiser en temps réel l'état des stations Vélib' à Paris et de planifier des itinéraires cyclables précis.

---

## 📑 Table des Matières

1.  [Configuration du Projet](#️-configuration-du-projet)
    * [Pré-requis](#1pré-requis)
    * [Installation des Dépendances](#2installation-des-dépendances)
    * [Déploiement avec Docker Compose](#-déploiement-avec-docker-compose)
    * [Service Docker](#services-docker)
    * [Docker-compose ](#docker-compose)
2.  [Fonctionnalités de l'application](#-fonctionnalités-de-lapplication)
3.  [Aperçu du Résultat](#️-aperçu-du-résultat)
    * [Vue d'Ensemble du Réseau Parisien](#1-vue-densemble-du-réseau-parisien)
    * [Démonstration de Routage Cyclable](#2-démonstration-de-routage-cyclable)
4.  [Conclusion du Projet](#conclusion-du-projet)
5.  [Structure du Code](#structure-du-code)

---

## Configuration du Projet

### 1.Pré-requis

Pour exécuter ce projet localement, vous devez avoir :

* **Python 3.8+**
* **Docker** installé afin de créer un container **MongoDB** grâce à un docker-compose.yml
* **Accès aux données Vélib'** (la base de données est configurée pour `velib_Paris`).

### 2.Installation des Dépendances

Installez toutes les bibliothèques requises :

```bash
# Installe les dépendances requises
pip install flask pymongo python-dotenv folium geopy requests polyline
```
### Déploiement avec Docker Compose

Pour exécuter facilement l'application Flask ainsi que sa base de données MongoDB dans un environnement isolé et reproductible, le projet inclut une configuration **Docker Compose**.

---

####  Services Docker

| Service | Rôle | Configuration importante |
|---------|------|---------------------------|
| **web (Flask App)** | Sert l’application et génère la carte interactive Vélib’ | • Construit l’image depuis le `Dockerfile`<br>• Lit l’URI MongoDB via la variable d’environnement **MONGO_URI**<br>• Communique automatiquement avec MongoDB grâce au réseau Docker |
| **mongo (MongoDB)** | Base de données contenant les stations Vélib’ | • Utilise un volume Docker pour **conserver les données**<br>• Le nom du conteneur (`mongo`) sert d’hôte interne pour la connexion |

---

#### Docker-compose 

``` yaml
version: '3.8'

services:
  mongo:
    image: mongo:7
    container_name: mongodb
    restart: unless-stopped
    environment:
      MONGO_INITDB_ROOT_USERNAME: admin
      MONGO_INITDB_ROOT_PASSWORD: admin
    ports:
      - "27017:27017"
    volumes:
      - mongo_data:/data/db
```

 Voir le fichier complet :  
[docker-compose.yml](/VELIB/docker-compose.yml)

---

## ✨ Fonctionnalités de l'application

* **Visualisation en Temps Réel** : Les marqueurs de stations sont colorés selon la disponibilité des vélos (Vert pour disponible, Rouge pour vide).
* **Planification d'Itinéraire (Routage Cyclable)** : Utilisation de l'API **OSRM (Open Source Routing Machine)** pour tracer des chemins précis qui suivent les routes cyclables réelles.
* **Informations de Navigation** : Affiche la distance totale, la durée estimée du trajet, et des instructions détaillées étape par étape.
* **Interface Simple** : Une barre latérale fixe gère la sélection des stations de départ et d'arrivée.

---

## Aperçu du Résultat


Pour illustrer le fonctionnement de cette application, nous présentons deux vues clés. Les images se trouvent dans le dossier **`VELIB/Image/`**.

### 1. Vue d'Ensemble du Réseau Parisien

Cette image montre la densité des stations et leur statut de disponibilité actuel dans Paris.

| Couleur | Statut | Description |
|---------|---------|-------------|
| 🟩 **Vert** | Stock élevé | Vélos disponibles en grand nombre avec un grand nombre de place disponible  |
| 🟧 **Orange** | Stock modéré | Vélos disponibles mais quantité moyenne avec peu de place disponible |
| 🟥 **Rouge** | Très faible stock | Très peu de vélos encore disponibles et un nombre de place très restreint |

![Aperçu de toutes les stations Vélib' sur la carte](VELIB/Image/UneStation.png)

### 2. Démonstration de Routage Cyclable

**Cette capture met en évidence la fonctionnalité principale : le planificateur de route.**
* On peut programmer un trajet d'un point A à un point B. Si la station d'arrivée à une **disponiblité quasi nulle**, elle s'affichera en **noir**.
* On retrouve également **la durée estimée du trajet** ainsi que **sa distance à parcourir**
* On a également tout en bas, la liste des instructions de route à suivre pour arriver le plus vite.

![Exemple de tracé de route cyclable avec instructions de navigation](VELIB/Image/Trajet.png)


## Conclusion du Projet

Ce projet combine trois domaines techniques majeurs pour offrir une solution complète et cohérente :

### 1. Gestion de la Donnée (MongoDB)
L’application se connecte à une base de données NoSQL pour récupérer un jeu de données complexe :  
les stations Vélib' ainsi que leur statut dynamique (vélos disponibles, places libres, etc.) doivent être actualiser très souvent

### 2. Architecture Web (Python Flask)
Flask sert de pont entre l'utilisateur et la logique métier :  
- gestion des requêtes HTTP  
- maintien de l’état du formulaire (départ / arrivée)  
- coordination des processus (sélection → requête → affichage)

### 3. Cartographie & Routage (Folium & OSRM)
L’application dépasse la simple visualisation :  
- intégration d’un moteur de routage open source (OSRM)  
- tracé précis suivant les routes réelles  
- calcul de la durée du trajet  
- génération d’instructions détaillées

---

## Défis Surmontés

### Stabilité de l’Interface (Flask / JS)
Résolution du problème classique du `onchange` en Flask, qui causait :  
- des rafraîchissements intempestifs  
- un comportement non prévisible  
→ L’interface est désormais fluide et stable.

### Défis liés aux APIs de Routage

Lors du développement, plusieurs solutions de routage géospatial ont été testées avant d’aboutir à une version stable. Deux APIs se sont révélées difficiles ou incompatibles avec les objectifs du projet :

####  OpenRouteService (ORS)
L’intégration d’ORS a échoué pour plusieurs raisons :
- **Problèmes d’authentification** : la clé API encodée était sensible au format exact attendu, entraînant des erreurs récurrentes.
- **Snapping trop strict** : l’API impose d'accrocher précisément les coordonnées aux routes.  
  → Cela provoquait des messages d’erreur du type *“Route not found”* même pour des trajets valides dans Paris.
- **Instabilité générale** pour des trajets courts ou très urbains comme ceux des stations Vélib’.

####  Google Maps Directions API
Google Maps Directions n’a finalement pas été intégrée car :
- elle nécessite systématiquement **un compte de facturation actif**,  
- c’est un **service payant**, même pour une utilisation basique,
- cela allait à l’encontre de l’objectif du projet : **rester 100% gratuit et open source**.

Ces contraintes ont mené au choix d’**OSRM**, une solution open source, performante et complètement gratuite, parfaitement adaptée aux besoins du projet.
L’utilisation de la librairie `polyline` a permis de décoder les données envoyées par OSRM,
transformant une simple ligne droite en **véritable itinéraire navigable** conforme au réseau routier.