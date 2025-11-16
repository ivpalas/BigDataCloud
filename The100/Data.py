import os
import dotenv
from neo4j import GraphDatabase

dotenv_path = os.path.join(os.path.dirname(__file__), '.env')
dotenv.load_dotenv(dotenv_path)

CYPHER_FILE = "the100_data.cypher"
uri = os.getenv("NEO4J_URI", "bolt://localhost:7687")
user = os.getenv("NEO4J_USER", "neo4j")
password = os.getenv("NEO4J_PASSWORD")
database_name = "the100"

if not password:
    print("FATAL: Le mot de passe Neo4j n'a pu être lu du fichier .env.")
    exit()

def is_only_comment_or_empty(query: str) -> bool:
    """
    Retourne True si la requête ne contient que des commentaires // ou est vide.
    """
    lines = query.strip().split("\n")
    for line in lines:
        stripped = line.strip()
        if stripped == "":
            continue
        if not stripped.startswith("//"):
            return False
    return True

def run_cypher_file(driver):
    cypher_path = os.path.join(os.path.dirname(__file__), CYPHER_FILE)

    if not os.path.exists(cypher_path):
        print(f"FATAL: fichier Cypher introuvable : {cypher_path}")
        return
    
    with open(cypher_path, 'r', encoding='utf-8') as f:
        cypher_content = f.read()

    # Découpage brut
    raw_queries = cypher_content.split(';')
    valid_queries = []

    for q in raw_queries:
        q = q.strip()
        if q and not is_only_comment_or_empty(q):
            valid_queries.append(q)

    print(f"Importation de {len(valid_queries)} requêtes…")

    total_nodes = 0
    total_relationships = 0

    try:
        with driver.session(database=database_name) as session:
            for idx, query in enumerate(valid_queries):
                result = session.run(query)
                summary = result.consume()

                total_nodes += summary.counters.nodes_created
                total_relationships += summary.counters.relationships_created

        print("\n--- Importation réussie ---")
        print(f"Nœuds créés : {total_nodes}")
        print(f"Relations créées : {total_relationships}")

    except Exception as e:
        print(f"\n❌ Erreur à la requête {idx+1}")
        print(query)   # <--- super utile pour debug
        print(e)

try:
    driver = GraphDatabase.driver(uri, auth=(user, password))

    with driver.session(database=database_name) as session:
        session.run("MATCH (n) DETACH DELETE n").consume()
        print("Base vidée.")

    run_cypher_file(driver)
    driver.close()

except Exception as e:
    print(f"Erreur critique : {e}")
