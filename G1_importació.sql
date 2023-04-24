-- Gym
DROP TABLE IF EXISTS aux_gyms CASCADE;
CREATE TABLE IF NOT EXISTS aux_gyms (
    leader VARCHAR(255),
    location VARCHAR(255),
	type VARCHAR(255),
	badge VARCHAR(255),
	name VARCHAR(255)
);

COPY aux_gyms FROM 'C:/Users/Public/CSV_BBDD/gyms.csv' DELIMITER ',' CSV HEADER;


-- Encounters
DROP TABLE IF EXISTS aux_encounters CASCADE;
CREATE TABLE IF NOT EXISTS aux_encounters (
    pokemon VARCHAR(255),
    subareaID INTEGER,
	method VARCHAR(255),
	condition_type VARCHAR(255),
	condition_value VARCHAR(255),
	chance INTEGER,
	min_level INTEGER,
	max_level INTEGER
);
	
COPY aux_encounters FROM 'C:/Users/Public/CSV_BBDD/encounters.csv' DELIMITER ',' CSV HEADER;

-- Locations
DROP TABLE IF EXISTS aux_locations CASCADE;	
CREATE TABLE IF NOT EXISTS aux_locations (
    region VARCHAR(255),
    area VARCHAR(255),
	subarea VARCHAR(255),
	subareaID INTEGER,
	population INTEGER
);
	
COPY aux_locations FROM 'C:/Users/Public/CSV_BBDD/locations.csv' DELIMITER ',' CSV HEADER;

-- Routes
DROP TABLE IF EXISTS aux_routes CASCADE;	
CREATE TABLE IF NOT EXISTS aux_routes (
    Route VARCHAR(255),
    North VARCHAR(255),
	East VARCHAR(255),
	West VARCHAR(255),
	South VARCHAR(255),
	Pavement VARCHAR(255)
);
	
COPY aux_routes FROM 'C:/Users/Public/CSV_BBDD/routes.csv' DELIMITER ',' CSV HEADER;
