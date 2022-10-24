from neo4j import GraphDatabase

driver = GraphDatabase.driver('bolt://0.0.0.0:7687',
                              auth=('neo4j', 'neo4j'))

query = '''
MATCH ()-[r:APPEAR_IN]-()
RETURN startNode(r), endNode(r)
'''

with driver.session() as session:
    result = session.run(query).data()
    print(result)