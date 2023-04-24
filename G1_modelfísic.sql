-- Region
DROP TABLE IF EXISTS Region CASCADE;
CREATE TABLE IF NOT EXISTS Region (
    ID_region SERIAL PRIMARY KEY,
    name VARCHAR(255)
);

-- Area
DROP TABLE IF EXISTS Area CASCADE;
CREATE TABLE IF NOT EXISTS Area (
    ID_area SERIAL PRIMARY KEY,
    name VARCHAR(255),
    ID_region INTEGER,
    FOREIGN KEY (ID_region) REFERENCES Region (ID_region)
);

-- Pavement
DROP TABLE IF EXISTS Pavement CASCADE;
CREATE TABLE IF NOT EXISTS Pavement (
    ID_pavement SERIAL PRIMARY KEY,
    type VARCHAR(255)
);

-- Route
DROP TABLE IF EXISTS Route CASCADE;
CREATE TABLE IF NOT EXISTS Route (
    ID_route SERIAL PRIMARY KEY,
    km_length INTEGER,
    ID_pavement INTEGER,
    FOREIGN KEY (ID_route) REFERENCES Area (ID_area),
    FOREIGN KEY (ID_pavement) REFERENCES Pavement (ID_pavement)
);


-- Route + Area
DROP TABLE IF EXISTS Route_Area CASCADE;
CREATE TABLE IF NOT EXISTS Route_Area (
    ID_area INTEGER,
    ID_route INTEGER,
    route_cardinal_point VARCHAR(255),
	PRIMARY KEY (ID_area, ID_route),
    FOREIGN KEY (ID_area) REFERENCES Area (ID_area),
    FOREIGN KEY (ID_route) REFERENCES Route (ID_route)
);


-- Badge
DROP TABLE IF EXISTS Badge CASCADE;
CREATE TABLE IF NOT EXISTS Badge (
    ID_badge SERIAL PRIMARY KEY,
    nom VARCHAR(255) NOT NULL
);

-- Object

-- Trainer

-- Leader
DROP TABLE IF EXISTS Leader CASCADE;
CREATE TABLE IF NOT EXISTS Leader (
    ID_leader SERIAL PRIMARY KEY,
    FOREIGN KEY (ID_leader) REFERENCES Trainer (ID_trainer)
);

-- Specie

-- Gym
CREATE TABLE IF NOT EXISTS Gym (
    ID_gym SERIAL PRIMARY KEY,
    name VARCHAR(255),
    ID_badge INTEGER,
    ID_object INTEGER,
    ID_leader INTEGER,
    ID_specie INTEGER,
    FOREIGN KEY (ID_badge) REFERENCES Badge (ID_badge),
    FOREIGN KEY (ID_object) REFERENCES Object (ID_object),
    FOREIGN KEY (ID_leader) REFERENCES Leader (ID_leader),
    FOREIGN KEY (ID_specie) REFERENCES Specie (ID_specie)
);

-- City
DROP TABLE IF EXISTS City CASCADE;
CREATE TABLE IF NOT EXISTS City (
    ID_city SERIAL PRIMARY KEY,
    ID_gym INTEGER,
    population INTEGER,
    FOREIGN KEY (ID_city) REFERENCES Area (ID_area),
    FOREIGN KEY (ID_gym) REFERENCES Gym (ID_gym)
);

-- Trainer + Badge
DROP TABLE IF EXISTS Trainer_Badge CASCADE;
CREATE TABLE IF NOT EXISTS Trainer_Badge (
    ID_trainer INTEGER,
    ID_badge INTEGER,
	PRIMARY KEY (ID_trainer, ID_badge),
    FOREIGN KEY (ID_trainer) REFERENCES Trainer (ID_trainer),
    FOREIGN KEY (ID_badge) REFERENCES Badge (ID_badge)
);

-- Subarea
DROP TABLE IF EXISTS Subarea CASCADE;
CREATE TABLE IF NOT EXISTS Subarea (
    ID_subarea SERIAL PRIMARY KEY,
    name VARCHAR(255),
    ID_area INTEGER,   -- Subarea cannot exist without Area
    FOREIGN KEY (ID_subarea) REFERENCES Area (ID_area),
    FOREIGN KEY (ID_area) REFERENCES Area (ID_area)
);

-- Method
DROP TABLE IF EXISTS Encounter_Method CASCADE;
CREATE TABLE IF NOT EXISTS Encounter_Method (
    ID_method SERIAL PRIMARY KEY,
    method_type VARCHAR(255)
);

-- Condition Type
DROP TABLE IF EXISTS Condition_Type CASCADE;
CREATE TABLE IF NOT EXISTS Condition_Type (
    ID_condition SERIAL PRIMARY KEY,
    condition_type VARCHAR(255),
    condition_value VARCHAR(255)
);

-- Specie

-- Condition Type + Specie + Subarea + Method
DROP TABLE IF EXISTS Specie_Subarea_Condition_Method CASCADE;
CREATE TABLE IF NOT EXISTS Specie_Subarea_Condition_Method (
    ID_method INTEGER,
    ID_subarea INTEGER,
    ID_specie INTEGER,
    chance VARCHAR(255),
    ID_condition INTEGER,
	PRIMARY KEY (ID_method, ID_subarea),
    FOREIGN KEY (ID_method) REFERENCES Encounter_Method (ID_method),
    FOREIGN KEY (ID_subarea) REFERENCES Subarea (ID_subarea),
    FOREIGN KEY (ID_specie) REFERENCES Specie (ID_specie), 
    FOREIGN KEY (ID_condition) REFERENCES Condition_Type (ID_condition)
);

-- Trainer + Gym
DROP TABLE IF EXISTS Trainer_Gym CASCADE;
CREATE TABLE IF NOT EXISTS Trainer_Gym (
    ID_trainer SERIAL,
    ID_gym SERIAL,
	PRIMARY KEY (ID_trainer, ID_gym),
    FOREIGN KEY (ID_trainer) REFERENCES Trainer (ID_trainer),
    FOREIGN KEY (ID_gym) REFERENCES Gym (ID_gym)
);