----------------
-- #Query 1.1#
--

SELECT DISTINCT
    s.name AS nombre,
    s_defensa.base_stat AS defensa,
    s_special.base_stat AS defensa_especial,
    s.weight
FROM pokemon AS p
INNER JOIN specie AS s ON p.id_specie = s.id_specie
INNER JOIN specie_ability AS sa ON sa.id_specie = s.id_specie
INNER JOIN ability AS ab ON sa.id_ability = ab.id_ability
INNER JOIN specie_stat AS s_defensa ON s_defensa.id_specie = s.id_specie 
INNER JOIN stat AS def ON s_defensa.id_stat = def.id_stat
INNER JOIN specie_stat AS s_special ON s_special.id_specie = s.id_specie 
INNER JOIN stat AS sp_def ON s_special.id_stat = sp_def.id_stat
WHERE
    def.stat_name LIKE 'defense' AND
    sp_def.stat_name LIKE 'special_defense' AND
    ab.name LIKE 'sturdy'
ORDER BY
    s.weight DESC
LIMIT 10;

-- #Validation#

SELECT s.name
FROM pokemon AS p
INNER JOIN specie AS s ON p.id_specie = s.id_specie
INNER JOIN specie_ability AS sa ON sa.id_specie = s.id_specie
INNER JOIN ability AS ab ON sa.id_ability = ab.id_ability
JOIN specie AS s1 ON s1.id_specie = p.id_specie 
WHERE ab.name LIKE 'sturdy'
GROUP BY  s.name
ORDER BY MAX(s.weight) DESC;



----------------
-- #Query 1.2#

SELECT AVG(base_stat) AS daño_medio, MAX(base_stat) AS daño_max, MIN(base_stat) AS daño_min
FROM Specie_Stat
INNER JOIN Pokemon_Types ON Specie_Stat.ID_specie = Pokemon_Types.ID_specie AND Specie_Stat.ID_stat = 10 
INNER JOIN Types ON Pokemon_Types.ID_type = Types.ID_type
WHERE Types.name = 'fire';


-- #Validation#

SELECT p.nickname, ss.base_stat, p.ID_specie
FROM Pokemon p
JOIN Pokemon_Types pt ON p.ID_specie = pt.ID_specie
JOIN Specie_Stat ss ON p.ID_specie = ss.ID_specie AND ss.ID_stat = 10 
JOIN Types t ON pt.ID_type = t.ID_type
WHERE t.name = 'fire'
ORDER BY ss.base_stat DESC
LIMIT 1; 

SELECT p.nickname, ss.base_stat, p.ID_specie
FROM Pokemon p
JOIN Pokemon_Types pt ON p.ID_specie = pt.ID_specie
JOIN Specie_Stat ss ON p.ID_specie = ss.ID_specie AND ss.ID_stat = 10 
JOIN Types t ON pt.ID_type = t.ID_type
WHERE t.name = 'fire'
ORDER BY ss.base_stat ASC
LIMIT 1; 


----------------
-- #Query 1.3#

SELECT Ability.name AS nombre_habilidad, Ability.effect AS efecto, s.name AS nombre_especie, s.base_experience 
FROM Specie_Ability 
JOIN Specie AS s ON Specie_Ability.ID_specie = s.ID_specie 
JOIN Ability ON Specie_Ability.ID_ability = Ability.ID_ability 
WHERE s.base_experience > (SELECT AVG(base_experience) FROM Specie) 
ORDER BY Ability.name, s.base_experience DESC;

-- #Validation#

SELECT AVG(base_experience) as media FROM Specie;

SELECT base_experience AS exp FROM Specie WHERE specie.name = 'porygon-z'; 
--. ahora calculamos las medias 
SELECT AVG(s_dmg.base_stat) AS avg_base_dmg, 
MAX(s_dmg.base_stat) AS max_base_dmg, 
MIN(s_dmg.base_stat) AS min_base_dmg
FROM Pokemon p 
JOIN Specie s ON p.ID_specie = s.ID_specie 
JOIN Specie_Stat s_dmg ON s.ID_specie = s_dmg.ID_specie 
JOIN Stat st_dmg ON s_dmg.ID_stat = st_dmg.ID_stat 
JOIN Types t ON s.ID_specie = t.ID_type 
WHERE t.name = 'fire' 
  	AND st_dmg.stat_name = 'attack';


----------------
-- #Query 1.4#

SELECT s2.name AS evolved_pokemon, stat.stat_name, MAX(ss.base_stat)
FROM Specie s1
JOIN Evolve e ON e.ID_current_specie = s1.ID_specie
JOIN Specie s2 ON e.ID_next_specie = s2.ID_specie
JOIN Specie_Stat ss ON s2.ID_specie = ss.ID_specie
JOIN Stat stat ON stat.id_stat = ss.id_stat
JOIN (
    		SELECT s1.ID_specie
    			FROM Specie s1
   	 		JOIN Specie_Stat ss1 ON s1.ID_specie = ss1.ID_specie
) sb ON s1.ID_specie = sb.ID_specie
WHERE e.is_baby = true
GROUP BY s2.name, stat.stat_name, s2.id_specie
ORDER BY MAX(ss.base_stat) DESC, s2.id_specie ASC;


-- #Validation#

SELECT s1.name AS baby_pokemon, s2.name as evolucion , e.is_baby
FROM Specie s1
JOIN Evolve e ON e.ID_current_specie = s1.ID_specie
JOIN Specie s2 ON e.ID_next_specie = s2.ID_specie
JOIN Specie_Stat ss ON s2.ID_specie = ss.ID_specie
JOIN Stat stat ON stat.id_stat = ss.id_stat
JOIN (
SELECT s1.ID_specie
FROM Specie s1
JOIN Specie_Stat ss1 ON s1.ID_specie = ss1.ID_specie
) sb ON s1.ID_specie = sb.ID_specie
WHERE e.is_baby = true
GROUP BY s1.name, s2.name, stat.stat_name, s2.id_specie, e.is_baby
ORDER BY MAX(ss.base_stat) DESC, s2.id_specie ASC;



----------------
-- #Query 1.5#

SELECT t.name 
FROM Types t 
JOIN Relation r ON t.ID_type = r.ID_type1 OR t.ID_type = r.ID_type2 
GROUP BY t.name 
HAVING COUNT(CASE WHEN CAST(substring(r.multiplier FROM 2) AS FLOAT) > 1 THEN 1 END) = 
    (SELECT COUNT(CASE WHEN CAST(substring(r.multiplier FROM 2) AS FLOAT) > 1 THEN 1 END)
    FROM Types t 
    JOIN Relation r ON t.ID_type = r.ID_type1 OR t.ID_type = r.ID_type2 
    GROUP BY t.name 
    ORDER BY COUNT(CASE WHEN CAST(substring(r.multiplier FROM 2) AS FLOAT) > 1 THEN 1 END) DESC
    LIMIT 1)
    OR COUNT(CASE WHEN CAST(substring(r.multiplier FROM 2) AS FLOAT) < 1 THEN 1 END) = 
    (SELECT COUNT(CASE WHEN CAST(substring(r.multiplier FROM 2) AS FLOAT) < 1 THEN 1 END)
    FROM Types t 
    JOIN Relation r ON t.ID_type = r.ID_type1 OR t.ID_type = r.ID_type2 
    GROUP BY t.name 
    ORDER BY COUNT(CASE WHEN CAST(substring(r.multiplier FROM 2) AS FLOAT) < 1 THEN 1 END) DESC
    LIMIT 1)
LIMIT 2;




-- #Validation#

SELECT t.name,
COUNT (CASE WHEN CAST(substring(r.multiplier FROM 2) AS FLOAT) > 1 THEN 1 END) AS strength_count, 
COUNT(CASE WHEN CAST(substring(r.multiplier FROM 2) AS FLOAT) < 1 THEN 1 END) AS resistance_count 
FROM Types t 
JOIN Relation r ON t.ID_type = r.ID_type1 OR t.ID_type = r.ID_type2 
GROUP BY t.name
ORDER BY strength_count DESC
LIMIT 1;

SELECT t.name, 
COUNT(CASE WHEN CAST(substring(r.multiplier FROM 2) AS FLOAT) > 1 THEN 1 END) AS strength_count, 
COUNT(CASE WHEN CAST(substring(r.multiplier FROM 2) AS FLOAT) < 1 THEN 1 END) AS resistance_count 
FROM Types t 
JOIN Relation r ON t.ID_type = r.ID_type1 OR t.ID_type = r.ID_type2 
GROUP BY t.name 
ORDER BY resistance_count DESC 
LIMIT 1;


----------------
-- #Query 1.6#

SELECT s.name AS primary_evolution, s2.name AS second_evolution, s3.name AS final_evolution,
    SUM(CASE WHEN gr.id_level <= e.min_level THEN gr.experience ELSE 0 END) +
    SUM(CASE WHEN gr2.id_level <= e2.min_level THEN gr2.experience ELSE 0 END)as experience
FROM evolve AS e
JOIN specie AS s ON s.id_specie = e.id_current_specie
JOIN growth_level AS gr ON s.growth_rate_id = gr.id_growth_rate
JOIN specie AS s2 ON s2.id_specie = e.id_next_specie
JOIN growth_level AS gr2 ON s2.growth_rate_id = gr2.id_growth_rate
JOIN evolve AS e2 ON e2.id_current_specie = e.id_next_specie
JOIN specie AS s3 ON s3.id_specie = e2.id_next_specie
JOIN growth_level AS gr3 ON s3.growth_rate_id = gr3.id_growth_rate
LEFT JOIN evolve AS e3 ON e3.id_current_specie = e2.id_next_specie
WHERE e.min_level > 0
    AND gr.id_level <= e.min_level
    AND gr2.id_level <= e2.min_level
GROUP BY s.name, s2.name, s3.name
ORDER BY experience DESC;

-- #Validation#
-- Per a poder mirar la validació hem consultat la taula d'evolucions per a comprovar que la cadena evolutiva que mostra la query com a resultat coincideix amb les evolucions dels pokemon.

----------------
-- #Trigger 1.1#

CREATE OR REPLACE FUNCTION check_max_types()
RETURNS TRIGGER AS $$
BEGIN
  IF (SELECT COUNT(*) FROM pokemon_types WHERE id_specie = NEW.id_specie) >= 2 THEN
    INSERT INTO warnings (affected_table, error_message, date, user_warning)
    VALUES ('pokemon_types', 'An entry has been inserted into the pokemon_types table', CURRENT_DATE, current_user);
    RETURN NULL; -- Evita que se realice la inserción en pokemon_types
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER check_max_types_trigger
BEFORE INSERT ON pokemon_types
FOR EACH ROW
EXECUTE FUNCTION check_max_types();

CREATE OR REPLACE FUNCTION check_max_abilities()
RETURNS TRIGGER AS $$
BEGIN
  IF (SELECT COUNT(*) FROM specie_ability WHERE id_specie = NEW.id_specie AND is_hidden = false) >= 2 THEN
    INSERT INTO warnings (affected_table, error_message, date, user_warning)
    VALUES ('specie_ability', 'An entry has been inserted into the specie_ability table', CURRENT_DATE, 'postgre');
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER check_max_abilities_trigger
BEFORE INSERT ON specie_ability
FOR EACH ROW
EXECUTE FUNCTION check_max_abilities();


-- #Validation#

INSERT INTO pokemon_types (id_specie, id_type, is_primary)
VALUES (1, 3, true);
SELECT * FROM warnings; 
SELECT * FROM pokemon_types where id_specie = 1;

INSERT INTO specie_ability (id_specie, id_ability, slot, is_hidden)
VALUES (1, 22, 2,false);
SELECT * FROM specie_ability Where id_specie = 1; 
SELECT * FROM warnings; 

----------------
-- #Trigger 1.2#

CREATE OR REPLACE FUNCTION check_evolution() RETURNS TRIGGER AS $$
DECLARE
    current_hour INTEGER;
BEGIN
    current_hour := EXTRACT(HOUR FROM current_timestamp);
    IF NEW.level >= Evolve.min_level
        AND NEW.gender = Evolve.gender
        AND current_hour >= 8 AND current_hour < 20
        AND NEW.trigger = 'level up' THEN
        SELECT ID_next_specie INTO NEW.ID_specie
        FROM Evolve
        WHERE ID_current_specie = NEW.ID_specie;

    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER check_evolution_trigger
BEFORE UPDATE ON Pokemon
FOR EACH ROW
EXECUTE FUNCTION check_evolution();


-- #Validation#
--Per a poder verificar que el trigger funciona correctament fem un insert en el primer pokemon de l'espècie com pot ser bulbasaoour i assignar-li un nivell major al seu nivell d'evolució que és el 16, per tant en tenir nivell 17 fent un insert hauria de disparar-se el disparador i assignar-li un id d'evolució diferent del pokemon en qüestió que hem canviat. Per tant la taula afectada serà la de pokemon on canviés la FK referent a id_specie.

