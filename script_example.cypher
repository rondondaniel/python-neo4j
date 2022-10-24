// Loading movies
LOAD CSV WITH HEADERS FROM 'https://raw.githubusercontent.com/pauldechorgnat/cool-datasets/master/mcu/movies.csv' AS row
CREATE (:Movie {id: row.tconst, 
                    title: row.primaryTitle, 
                    year:  toInteger(row.startYear), 
                    runtime:toInteger(row.runtimeMinutes), 
                    genres: split(row.genres, ',')
});

// Loading appearances
LOAD CSV WITH HEADERS FROM 'https://raw.githubusercontent.com/pauldechorgnat/cool-datasets/master/mcu/character_appears_in_movie.csv' AS row
MATCH (c:Character) WHERE c.name = row.character
MATCH (m:Movie) WHERE m.id = row.tconst
CREATE (c)-[:APPEAR_IN]->(m);

// Loading directions
LOAD CSV WITH HEADERS FROM 'https://raw.githubusercontent.com/pauldechorgnat/cool-datasets/master/mcu/person_directs_movie.csv' AS row
MATCH (p:Person) WHERE p.id = row.nconst
MATCH (m:Movie) WHERE m.id = row.tconst
CREATE (p)-[:DIRECTED]->(m);

// Loading productions
LOAD CSV WITH HEADERS FROM 'https://raw.githubusercontent.com/pauldechorgnat/cool-datasets/master/mcu/person_produces_movie.csv' AS row
MATCH (p:Person) WHERE p.id = row.nconst
MATCH (m:Movie) WHERE m.id = row.tconst
CREATE (p)-[:PRODUCED]->(m);