// Loading Stations
LOAD CSV WITH HEADERS FROM 'https://github.com/pauldechorgnat/cool-datasets/raw/master/ratp/stations.csv' AS row
CREATE (:Stations {name: row.nom_clean, 
                    x: toFloat(row.x),
                    y: toFLoat(row.y), 
                    traffic: toInteger(row.Trafic),
                    city: row.Ville,
                    line: row.ligne
});

// Loading Connections
LOAD CSV WITH HEADERS FROM 'https://github.com/pauldechorgnat/cool-datasets/raw/master/ratp/liaisons.csv' AS row
MATCH (start:Stations) WHERE start.name = row.start AND start.line = row.ligne
MATCH (stop:Stations) WHERE stop.name = row.stop AND stop.line = row.ligne
CREATE (start)-[:CONNECTIONS]->(stop);

// Create correspondence line
MATCH (start:Stations)
MATCH (stop:Stations)
WHERE start.name = stop.name AND start.line <> stop.line
CREATE (start)-[:CORRESPONDANCE]->(stop)

// Create correspondence walk
MATCH (s1:Stations)
MATCH (s2:Stations)
WITH s1.x as X1, s1.y as Y1, s2.x as X2, s2.y as Y2 
WHERE (SQRT(((X2 - X1) ^ 2) + ((Y2-Y1) ^ 2)) < 1000)
CREATE (start)-[:CORRESPONDANCE_WALK]->(stop)