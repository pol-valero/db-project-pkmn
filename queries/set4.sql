----------------
----------------
-- #Query 4.1.1#
--

SELECT r.name, COUNT(sub.ID_subarea) AS subarea_count
FROM Region AS r
JOIN Area AS a ON a.ID_region = r.ID_region
JOIN Subarea AS sub ON sub.ID_area = a.ID_area
GROUP BY r.name
ORDER BY subarea_count DESC
LIMIT 1;

-- #Validation#
-- if needed, write the validation queries (select, update, inserte, delete)

SELECT r.name AS region_name, COUNT(sa.ID_subarea) AS subarea_count
FROM Region r
LEFT JOIN Area a ON r.ID_region = a.ID_region
LEFT JOIN Subarea sa ON a.ID_area = sa.ID_area
GROUP BY r.ID_region, r.name;

----------------
----------------
-- #Query 4.1.2#
--

SELECT r.name, COUNT(sub.ID_subarea) AS subarea_count
FROM Region AS r
JOIN Area AS a ON a.ID_region = r.ID_region
JOIN Subarea AS sub ON sub.ID_area = a.ID_area
WHERE r.ID_region = (
	SELECT a.ID_region
	FROM Area AS a
	JOIN Subarea AS sub ON sub.ID_area = a.ID_area
	GROUP BY a.ID_region
	ORDER BY COUNT(sub.ID_subarea) DESC
	LIMIT 1
)
GROUP BY r.name
HAVING COUNT(sub.ID_subarea) >= (
	SELECT COUNT(sub.ID_subarea) AS subarea_count
	FROM Region AS r
	JOIN Area AS a ON a.ID_region = r.ID_region
	JOIN Subarea AS sub ON sub.ID_area = a.ID_area
	GROUP BY r.name
	ORDER BY COUNT(sub.ID_subarea) DESC
	LIMIT 1
);

-- #Validation#
-- if needed, write the validation queries (select, update, inserte, delete)

SELECT r.name AS region_name, COUNT(sa.ID_subarea) AS subarea_count
FROM Region r
LEFT JOIN Area a ON r.ID_region = a.ID_region
LEFT JOIN Subarea sa ON a.ID_area = sa.ID_area
GROUP BY r.ID_region, r.name;

----------------
-- #Query 4.2#
--

SELECT DISTINCT g.name AS gym_name, a.name AS area_name
FROM gym AS g
JOIN city AS c ON g.id_gym = c.id_gym
JOIN route AS r ON r.id_route = c.id_city
JOIN route_area AS ra ON ra.id_route = r.id_route
JOIN area AS a ON a.id_area = ra.id_area
AND r.km_length > 0;

-- #Validation#
-- if needed, write the validation queries (select, update, inserte, delete)

----------------
-- #Query 4.3#
--

SELECT * FROM Specie_Subarea_Condition_Method AS enc
JOIN Encounter_Method AS em ON em.id_method = enc.ID_method
JOIN Subarea AS sub ON sub.ID_subarea = enc.ID_subarea
JOIN Area AS a ON a.ID_area = sub.ID_area
JOIN Region AS r ON r.ID_region = a.ID_region
WHERE em.method_type LIKE 'surf' AND LOWER(r.name) LIKE 'sinnoh';

-- #Validation#
-- if needed, write the validation queries (select, update, inserte, delete)

SELECT * FROM Specie_Subarea_Condition_Method AS enc
JOIN Encounter_Method AS em ON em.id_method = enc.ID_method
JOIN Subarea AS sub ON sub.ID_subarea = enc.ID_subarea
JOIN Area AS a ON a.ID_area = sub.ID_area
JOIN Region AS r ON r.ID_region = a.ID_region
WHERE em.method_type LIKE 'surf';

SELECT * FROM Specie_Subarea_Condition_Method AS enc
JOIN Encounter_Method AS em ON em.id_method = enc.ID_method
JOIN Subarea AS sub ON sub.ID_subarea = enc.ID_subarea
JOIN Area AS a ON a.ID_area = sub.ID_area
JOIN Region AS r ON r.ID_region = a.ID_region
WHERE LOWER(r.name) LIKE 'sinnoh';

----------------
-- #Query 4.4#
--

SELECT p.nickname FROM Specie_Subarea_Condition_Method AS enc
JOIN Specie AS s ON s.ID_specie = enc.ID_specie
JOIN Pokemon AS p ON p.id_specie = s.ID_specie
WHERE enc.chance_percentage <= 1
GROUP BY p.nickname, enc.min_level_specie
ORDER BY enc.min_level_specie
LIMIT 1;

-- #Validation#
-- if needed, write the validation queries (select, update, inserte, delete)

SELECT enc.id_encounter FROM Specie_Subarea_Condition_Method AS enc
WHERE enc.chance_percentage <= 1
GROUP BY enc.id_encounter,enc.min_level_specie
ORDER BY enc.min_level_specie;

SELECT * FROM Specie_Subarea_Condition_Method as enc WHERE enc.id_encounter =  10640;
SELECT p.nickname,  p.id_subarea, p.id_specie, p.obtention_method 
FROM pokemon as p WHERE p.nickname LIKE '%Napo%' ;

----------------
-- #Query 4.5#
--

UPDATE Encounter_Method
SET method_type = 'good rod'
WHERE method_type = 'good';

UPDATE Encounter_Method
SET method_type = 'old rod'
WHERE method_type = 'old';

UPDATE Encounter_Method
SET method_type = 'super rod'
WHERE method_type = 'super';

-- Assignar la ID del mètode a un ID aleatori que no pertanyi al mètode de roca.
UPDATE Specie_Subarea_Condition_Method
SET ID_method = (
    SELECT ID_method
    FROM Encounter_Method
    WHERE method_type <> 'rock'
    ORDER BY random()
    LIMIT 1
)
WHERE ID_method IN (
    SELECT em.ID_method
    FROM Encounter_Method AS em
    WHERE em.method_type LIKE 'rock'
);

-- Esborrar el mètode de roca dins la taula.
DELETE FROM Encounter_Method
WHERE method_type = 'rock';

-- #Validation#
-- if needed, write the validation queries (select, update, inserte, delete)

SELECT *
FROM Encounter_Method
WHERE method_type = 'good' OR method_type = 'old' oR method_type = 'super';

SELECT *
FROM Encounter_Method;

----------------
-- #Query 4.6#
--

SELECT a.name FROM Area AS a    -- The area is the route
JOIN Route AS r ON r.ID_route = a.ID_area
JOIN Pavement AS p ON p.ID_pavement = r.ID_pavement
JOIN Subarea AS sub ON sub.ID_area = a.ID_area
JOIN Specie_Subarea_Condition_Method AS enc ON enc.ID_subarea = sub.ID_subarea
JOIN Condition AS c ON c.ID_condition = enc.ID_condition
WHERE p.type LIKE 'Grass' AND ((c.condition_type LIKE 'time' AND c.condition_value LIKE 'night') OR (c.condition_type LIKE 'weather' AND c.condition_value LIKE 'rain'));

-- #Validation#
-- if needed, write the validation queries (select, update, inserte, delete)

SELECT * FROM Pavement WHERE type LIKE 'Grass';

SELECT * FROM Condition WHERE condition_type LIKE 'time'
AND condition_value LIKE 'night';

SELECT * FROM Condition WHERE condition_type LIKE 'weather'
AND condition_value LIKE 'rain';

SELECT a.name, r.ID_route, sub.ID_subarea
FROM Area AS a
JOIN Route as r ON r.ID_route = a.ID_area
JOIN Subarea As sub ON sub.ID_area = a.ID_area;

----------------
-- #Trigger 4.1#
--

-- Si al afegir ciutats dona error de PK duplicada, usar aquesta sentència:
-- SELECT setval('city_id_city_seq', 550);

-- Enable pgcrypto extension for generating random names
CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- Function to generate the Lasalià region
CREATE OR REPLACE FUNCTION generate_lasalia_region(city_id INTEGER)
  RETURNS VOID AS $$
DECLARE
  lasalia_region_id INTEGER;
BEGIN
  -- Check if the 'Lasalià' region exists
  IF NOT EXISTS (SELECT 1 FROM Region WHERE name LIKE 'Lasalià') THEN
    INSERT INTO Region (name)
    VALUES ('Lasalià')
    RETURNING ID_region INTO lasalia_region_id;
  ELSE
    SELECT ID_region INTO lasalia_region_id
    FROM Region
    WHERE name LIKE 'Lasalià';
  END IF;

  UPDATE Area
  SET ID_region = lasalia_region_id
  WHERE ID_area = city_id;
END;
$$ LANGUAGE plpgsql;

-- Function to generate a random Trainer
CREATE OR REPLACE FUNCTION generate_random_trainer()
  RETURNS INTEGER AS $$
DECLARE
  random_trainer_id INTEGER;
BEGIN
  INSERT INTO Trainer (name, exp_points, gold, class, gift_item)
  VALUES (gen_random_uuid()::text, 0, 0, '', NULL)
  RETURNING ID_trainer INTO random_trainer_id;
  
  RETURN random_trainer_id;
END;
$$ LANGUAGE plpgsql;

-- Function to insert Trainer as a Gym Leader
CREATE OR REPLACE FUNCTION insert_trainer_as_leader(trainer_id INTEGER)
  RETURNS VOID AS $$
BEGIN
  INSERT INTO Gym_Leader (ID_gym_leader)
  VALUES (trainer_id);
END;
$$ LANGUAGE plpgsql;

-- Function to create a random Gym
CREATE OR REPLACE FUNCTION create_random_gym(leader_id INTEGER)
  RETURNS INTEGER AS $$
DECLARE
  random_gym_id INTEGER;
BEGIN
  INSERT INTO Gym (name, ID_leader)
  VALUES ('Gym ' || gen_random_uuid()::text, leader_id)
  RETURNING ID_gym INTO random_gym_id;
  
  RETURN random_gym_id;
END;
$$ LANGUAGE plpgsql;

-- Trigger Function
CREATE OR REPLACE FUNCTION crear_region_lasalia()
  RETURNS TRIGGER AS $$
DECLARE
  random_trainer_id INTEGER;
  random_gym_id INTEGER;
BEGIN
	-- Generate the Lasalià region (with no expected return value)
	PERFORM generate_lasalia_region(NEW.ID_city);

	-- Generate a random Trainer
	random_trainer_id := generate_random_trainer();
  
	-- Insert the Trainer as a Gym Leader
	PERFORM insert_trainer_as_leader(random_trainer_id);

	-- Create a random Gym
	random_gym_id := create_random_gym(random_trainer_id);

	-- Update the City with the random Gym
	UPDATE City
	SET ID_gym = random_gym_id, population = FLOOR(RANDOM() * 10000 + 1)::INTEGER
	WHERE ID_city = NEW.ID_city;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger Creation
CREATE TRIGGER crear_informacion_minima
AFTER INSERT ON City
FOR EACH ROW
EXECUTE FUNCTION crear_region_lasalia();

-- #Validation#
-- if needed, write the validation queries (select, update, inserte, delete)

INSERT INTO City(ID_city)
VALUES(1);

INSERT INTO City(ID_city)
VALUES(2);

SELECT * FROM Region;
SELECT * FROM Gym;
SELECT * FROM Gym_Leader;
SELECT * FROM Trainer;

----------------
-- #Trigger 4.2#
--

-- Si al afegir entrenadors dona error de PK duplicada, usar aquesta sentència:
-- SELECT setval('trainer_id_trainer_seq', 550);

CREATE OR REPLACE FUNCTION create_warning(trainer_name VARCHAR(255), specie_name VARCHAR(255), route_name VARCHAR(255))
RETURNS VOID AS $$
BEGIN
  INSERT INTO Warnings (affected_table, error_message, date, user_warning)
  VALUES ('Encounter', 'Trainer ' || trainer_name || ' captured ' || specie_name || ' in ' || route_name || ', with either incorrect method, level, or capture chance.', CURRENT_DATE, trainer_name);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION valid_chance(chance_percentage INTEGER)
RETURNS BOOLEAN AS $$
BEGIN
  RETURN (chance_percentage > 0);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION valid_range(pokemon_level INTEGER, max_level INTEGER, min_level INTEGER)
RETURNS BOOLEAN AS $$
BEGIN
  RETURN (min_level <= pokemon_level AND max_level >= pokemon_level);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION valid_pavement(pavement_type VARCHAR(255), capture_method VARCHAR(255))
RETURNS BOOLEAN AS $$
BEGIN  
  RETURN (pavement_type LIKE 'water' AND capture_method like 'surf');
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION valid_method(pavement_type VARCHAR(255), capture_method VARCHAR(255))
RETURNS BOOLEAN AS $$
BEGIN
  RETURN (pavement_type NOT LIKE 'water' AND (capture_method like 'walk' OR capture_method LIKE 'headbutt'));
END;
$$ LANGUAGE plpgsql;

-- Trigger Function
CREATE OR REPLACE FUNCTION new_encounter()
  RETURNS TRIGGER AS $$
DECLARE
  pokemon_level INTEGER;
  chance_percentage INTEGER;
  pavement_type VARCHAR(255);
  capture_method VARCHAR(255);
  trainer_name VARCHAR(255);
  route_name VARCHAR(255);
  specie_name VARCHAR(255);
  max_level INTEGER;
  min_level INTEGER;
BEGIN
  SELECT pave.type, p.level, enc.chance_percentage, em.method_type, t.name, a.name, enc.min_level_specie, enc.max_level_specie, s.name
  INTO pavement_type, pokemon_level, chance_percentage, capture_method, trainer_name, route_name, min_level, max_level, specie_name
  FROM Pokemon AS p
  JOIN Trainer AS t ON t.ID_trainer = NEW.ID_trainer
  JOIN Subarea AS sub ON sub.ID_subarea = NEW.ID_subarea
  JOIN Area AS a ON a.ID_area = sub.ID_area
  JOIN Specie AS s ON s.ID_specie = NEW.ID_specie
  JOIN Route AS r ON r.ID_route = a.ID_area
  JOIN Pavement AS pave ON pave.ID_pavement = r.ID_pavement
  JOIN Specie_Subarea_Condition_Method AS enc ON enc.ID_subarea = sub.ID_subarea AND NEW.ID_specie = enc.ID_specie
  JOIN Encounter_Method AS em ON em.ID_method = enc.ID_method
  WHERE p.ID_pokemon = NEW.ID_pokemon AND p.obtention_method LIKE em.method_type;
	
  IF NOT (valid_chance(chance_percentage) AND valid_range(pokemon_level, max_level, min_level) AND (valid_pavement(pavement_type, capture_method) OR valid_method(pavement_type, capture_method))) THEN
    PERFORM create_warning(trainer_name, specie_name, route_name);
  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger Creation
CREATE TRIGGER crear_nuevo_encuentro
AFTER INSERT ON Pokemon
FOR EACH ROW
EXECUTE FUNCTION new_encounter();

-- #Validation#
-- if needed, write the validation queries (select, update, inserte, delete)

-- Encontra amb la subàrea 489 que té un àrea (ID = 6) per fer proves (l'àrea té paviment de 'water'), amb l'encontra amb chance > 0 i min_level = 1, max_level = 20.
INSERT INTO Specie_Subarea_Condition_Method(id_method, id_subarea, id_specie, chance_percentage, min_level_specie, max_level_specie, id_condition)
VALUES(1, 498, 63, 10, 1, 30, 4);

-- Crea warning degut al mètode walk a la subàrea 489.
INSERT INTO Pokemon(nickname, experience, gender, level, ID_trainer, ID_subarea, position, remaining_health, status_inflicted, id_specie, obtention_method, datetime)
VALUES('test', 5433223, 'male', 10, 3, 498, 4, 50, 'none', 63, 'walk', '2023-07-02 18:32:59');

-- No crea warning degut al mètode surf amb paviment 'water'.
INSERT INTO Pokemon(nickname, experience, gender, level, ID_trainer, ID_subarea, position, remaining_health, status_inflicted, id_specie, obtention_method, datetime)
VALUES('test', 5433223, 'male', 10, 3, 498, 4, 50, 'none', 63, 'surf', '2023-07-02 18:32:59');

-- Crea warning degut al nivell del pokèmon (fora del rang).
INSERT INTO Pokemon(nickname, experience, gender, level, ID_trainer, ID_subarea, position, remaining_health, status_inflicted, id_specie, obtention_method, datetime)
VALUES('test', 5433223, 'male', 40, 3, 498, 4, 50, 'none', 63, 'surf', '2023-07-02 18:32:59');