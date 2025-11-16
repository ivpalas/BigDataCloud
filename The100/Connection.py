import os
import dotenv
from neo4j import GraphDatabase

# Chemin vers le fichier .env (assumé dans le même dossier que ce script)
dotenv_path = os.path.join(os.path.dirname(__file__), '.env')
dotenv.load_dotenv(dotenv_path)

# --- Paramètres de connexion lus depuis .env ---
uri = os.getenv("NEO4J_URI", "bolt://localhost:7687") 
user = os.getenv("NEO4J_USER", "neo4j")
password = os.getenv("NEO4J_PASSWORD") 
database_name = "the100" 

# Sortie immédiate si les identifiants cruciaux ne sont pas trouvés (Minimum de sécurité)
if not password:
    print("FATAL: Le mot de passe Neo4j n'a pu être lu du fichier .env.")
    exit()

# Initialisation et exécution
driver = GraphDatabase.driver(uri, auth=(user, password))

def get_clarke_info(session):
    # Requête de test qui renvoie l'information sur Clarke Griffin
    query = "MATCH (p:Person) WHERE p.name = 'Clarke Griffin' RETURN p.name, p.title"
    result = session.run(query)
    
    print(f"Résultats (Base: {database_name}):")
    for record in result:
        print(record)

try:
    with driver.session(database=database_name) as session:
        get_clarke_info(session)
        
    driver.close()
    print("\nScript exécuté avec succès.")

except Exception as e:
    print(f"\nErreur critique lors de l'exécution: {e}")