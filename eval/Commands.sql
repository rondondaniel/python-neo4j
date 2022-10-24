// check special lines
MATCH (n) 
WHERE n.line IN ['7bis', '11', '3bis', '1', '7', '3'] 
RETURN n

// delete database
MATCH (n) 
DETACH DELETE n

// Create correspondence walk
MATCH (s1:Stations)
MATCH (s2:Stations)
WITH s1.x as X1, s1.y as Y1, s2.x as X2, s2.y as Y2 
WHERE (SQRT(((X2 - X1) ^ 2) + ((Y2-Y1) ^ 2)) < 1000)
CREATE (start)-[:CORRESPONDANCE_WALK]->(stop)

// view correspondances walk
MATch (n) 
match ()-[r:CORRESPONDANCE_WALK]-() 
WHERE n.line IN ['7bis', '7'] 
RETURN r, n