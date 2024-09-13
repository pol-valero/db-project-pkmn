----------------
----------------
-- #Query 2.1#
--

SELECT p.nickname, p.id_pokemon
FROM pokemon AS p
JOIN Team as tm ON p.id_team = tm.id_team 
WHERE p.position = 1 
AND tm.id_trainer = (SELECT id_trainer FROM Trainer_Defeats_Gym GROUP BY id_trainer ORDER BY COUNT(id_trainer) DESC LIMIT 1);

-- #Validation#
-- if needed, write the validation queries (select, update, inserte, delete)

INSERT INTO trainer_defeats_gym (id_trainer, id_gym)
VALUES (416,24), (416,28);

SELECT * FROM trainer_defeats_gym
ORDER BY id_trainer ASC, id_gym ASC; 

SELECT p.id_trainer, p.id_pokemon
FROM pokemon AS p
JOIN Team as tm ON p.id_team = tm.id_team 
WHERE p.position = 1 
AND tm.id_trainer = (SELECT id_trainer FROM Trainer_Defeats_Gym GROUP BY id_trainer ORDER BY COUNT(id_trainer) DESC LIMIT 1);


----------------
-- #Query 2.2#
--
SELECT p.nickname, t.name, COUNT (br.id_pokemon)
FROM pokemon AS p 
JOIN battle_result AS br ON br.id_pokemon = p.id_pokemon
JOIN Trainer AS t ON t.id_trainer = p.id_trainer
JOIN Battle AS b ON b.id_battle = br.id_battle
WHERE br.remaining_life = 0 AND b.winner = p.id_trainer
GROUP BY p.nickname, t.name, p.datetime
ORDER BY COUNT (br.id_pokemon) DESC, p.datetime ASC
LIMIT 5;


-- #Validation#
-- if needed, write the validation queries (select, update, inserte, delete)


----------------
-- #Query 2.3#
--
SELECT t.id_trainer, COUNT(p.id_pokemon)
FROM Trainer AS t
JOIN pokemon AS p ON p.id_trainer = t.id_trainer
WHERE p.experience > POW(t.gold, 2) AND 
    (SELECT COUNT(p.id_pokemon) 
    FROM pokemon AS p
    JOIN battle_result AS br ON br.id_pokemon = p.id_pokemon
    JOIN battle AS b ON b.id_battle = br.id_battle
    WHERE b.winner = t.id_trainer
    ) = 0
GROUP BY t.id_trainer;


-- #Validation#
-- if needed, write the validation queries (select, update, inserte, delete)
SELECT p.id_pokemon
FROM pokemon AS p
WHERE p.id_trainer = 59;

SELECT DISTINCT p.id_pokemon
FROM pokemon AS p
JOIN battle AS b ON b.loser = p.id_trainer
WHERE p.id_trainer = 59;

SELECT DISTINCT p.id_pokemon
FROM pokemon AS p
JOIN trainer AS t ON p.id_trainer = t.id_trainer
WHERE p.id_trainer = 59 AND p.experience < POW(t.gold, 2);

----------------
-- #Query 2.4#
--
SELECT co.name, t.name, tb.name, (t.gold + tb.gold) AS total_stolen_money
FROM Criminal_Org AS co
JOIN Villain AS v ON co.ID_org = v.ID_org
JOIN Villain AS vb ON v.buddy = vb.ID_villain
JOIN Trainer AS t ON t.ID_trainer = v.ID_villain
JOIN Trainer AS tb ON tb.ID_trainer = vb.ID_villain
WHERE (t.gold + tb.gold) = (
    	SELECT (t1.gold + t2.gold)
		FROM criminal_org AS org 
		JOIN Villain AS v1 ON v1.id_org = org.id_org 
		JOIN Villain AS v2 ON v1.buddy = v2.id_villain
		JOIN Trainer AS t1 ON t1.id_trainer = v1.id_villain
		JOIN Trainer AS t2 ON t2.id_trainer = v2.id_villain
		WHERE org.id_org = co.id_org
		ORDER BY (t1.gold + t2.gold) DESC
	  	LIMIT 1
);


-- #Validation#
-- if needed, write the validation queries (select, update, inserte, delete)
SELECT co.name, t.name, tb.name, (t.gold + tb.gold) AS total_stolen_money
FROM Criminal_Org AS co
JOIN Villain AS v ON co.ID_org = v.ID_org
JOIN Villain AS vb ON v.buddy = vb.ID_villain
JOIN Trainer AS t ON t.ID_trainer = v.ID_villain
JOIN Trainer AS tb ON tb.ID_trainer = vb.ID_villain;

----------------
-- #Query 2.5#
--
SELECT DISTINCT p1.nickname 
FROM Pokemon AS p1
JOIN battle_result AS br ON br.id_pokemon = p1.id_pokemon
JOIN Pokemon AS p2 ON br.id_pokemon =  p2.id_pokemon
JOIN pokemon_movement AS pm ON pm.id_pokemon = p2.id_pokemon
JOIN state AS s ON s.id_state = pm.id_movement
WHERE p1.status_inflicted IS NOT NULL 
AND p1.status_inflicted = s.status;


-- #Validation#
-- if needed, write the validation queries (select, update, inserte, delete)

----------------
-- #Query 2.6#
--
SELECT ty.ID_type, ty.name, COUNT(t.ID_trainer) AS leader_defeats
FROM Types AS ty
JOIN Gym AS g ON ty.ID_type = g.ID_type
JOIN Trainer AS t ON g.ID_leader = t.ID_trainer
JOIN Battle AS b ON t.ID_trainer = b.loser
GROUP BY ty.ID_type
HAVING COUNT(t.ID_trainer) = (
  SELECT MIN(defeats_count)
  FROM (
    SELECT COUNT(t.ID_trainer) AS defeats_count
    FROM Types AS ty
    JOIN Gym AS g ON ty.ID_type = g.ID_type
    JOIN Trainer AS t ON g.ID_leader = t.ID_trainer
    JOIN Battle AS b ON t.ID_trainer = b.loser
    GROUP BY ty.ID_type
  ) AS subquery
);


-- #Validation#
-- if needed, write the validation queries (select, update, inserte, delete)
SELECT ty.ID_type, ty.name, COUNT(t.ID_trainer) AS leader_defeats
FROM Types AS ty
JOIN Gym AS g ON ty.ID_type = g.ID_type
JOIN Trainer AS t ON g.ID_leader = t.ID_trainer
JOIN Battle AS b ON t.ID_trainer = b.loser
GROUP BY ty.ID_type;

----------------
-- #Trigger 2.1#
--
CREATE OR REPLACE FUNCTION update_movement()
RETURNS TRIGGER AS $$
BEGIN
    DECLARE
	trainer_id INTEGER;
        trainer_class VARCHAR(255);
        trainer_name VARCHAR(255);
        pokemon_species_id INTEGER;
        move_name VARCHAR(255);
        machine_id INTEGER;
    BEGIN
	
        -- Aconsegueix els atributs del nou trainer i moviment que volem entrar
        SELECT t.id_trainer, t.class, t.name, pm.ID_pokemon, m.name
        INTO trainer_id, trainer_class, trainer_name, pokemon_species_id, move_name
        FROM Trainer AS t
        JOIN Pokemon AS p ON t.ID_trainer = p.ID_trainer
        JOIN Pokemon_Movement AS pm ON p.ID_pokemon = pm.ID_pokemon
        JOIN Movement AS m ON pm.ID_movement = m.ID_movement
        WHERE pm.ID_pokemon = NEW.ID_pokemon AND pm.ID_movement = NEW.ID_movement;
        
        -- Comprovem si l’entrenador te una maquina de moviment que pugui ensenyar el moviment
        SELECT ID_machine
        INTO machine_id
        FROM Technical_Machine
        WHERE ID_movement = NEW.ID_movement
          AND ID_machine IN (
              SELECT ID_object
              FROM Trainer_Object
              WHERE ID_trainer = trainer_id
          );
        
        IF machine_id IS NOT NULL THEN
            -- Treiem la maquina de moviment de l’inventari
            DELETE FROM Trainer_Object
            WHERE ID_trainer = trainer_id
              AND ID_object = machine_id;
            
            -- Esborrem el moviment antic que estava a la posicio del nou moviment
            DELETE FROM Pokemon_Movement
            WHERE ID_pokemon = NEW.ID_pokemon
              AND ID_movement IN (
                  SELECT pm.ID_movement
                  FROM Pokemon_Movement AS pm
                  JOIN Movement AS m ON m.id_movement = pm.id_movement
                  WHERE priority_place = (
                      SELECT priority_place
                      FROM Movement
                      WHERE ID_movement = NEW.ID_movement
                  ) AND pm.ID_movement <> NEW.ID_movement
              );
            
            RETURN NEW;
        ELSE
            
            INSERT INTO Warnings (affected_table, error_message, date, user_warning)
			VALUES ('pokemon_movement',
    			(FORMAT('%s %s attempted to teach his %s the move %s without the necessary move machine.',
       			trainer_class::text, trainer_name::text, pokemon_species_id::text, move_name::text))
			, CURRENT_DATE, trainer_id);
		-- Desfem el INSERT
	     DELETE FROM pokemon_movement WHERE ID_pokemon = NEW.ID_pokemon AND ID_movement = NEW.ID_movement;
	   RETURN NEW;
        END IF;
    END;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS update_movement_trigger ON Pokemon_Movement;
CREATE TRIGGER update_movement_trigger
AFTER INSERT ON Pokemon_Movement
FOR EACH ROW
EXECUTE FUNCTION update_movement();

-- #Validation#
-- if needed, write the validation queries (select, update, inserte, delete)

INSERT INTO Pokemon_Movement(ID_pokemon, ID_movement)
VALUES (1,3);

--id_machine 305 te el id_movement 5
--id_pokemon 1 te el id_trainer 0

INSERT INTO Trainer_Object (ID_trainer, ID_object, datetime)
VALUES (0, 305, CURRENT_DATE);

INSERT INTO Pokemon_Movement(ID_pokemon, ID_movement)
VALUES (1,5);


----------------
-- #Trigger 2.2#
-- 
CREATE OR REPLACE FUNCTION update_trainer()
  RETURNS TRIGGER AS $$
DECLARE
    loser_is_gym_leader BOOLEAN;
    winner_is_villain BOOLEAN;
    leader_gym_object INTEGER;
BEGIN
    -- Comprovem si el perdedor es un lider de gimnas
    SELECT COUNT(*) INTO loser_is_gym_leader
    FROM Gym_Leader
    WHERE ID_gym_leader = NEW.loser;
    
    -- Comprovem si el guanyador es un malvat
    SELECT COUNT(*) INTO winner_is_villain
    FROM Villain
    WHERE ID_villain = NEW.winner;
    
    -- Actualitzem el or i experiencia del perdedor i guanyador
    UPDATE Trainer
    SET gold = gold + NEW.gold_reward,
        exp_points = exp_points + (NEW.exp_reward * 2 / 3)
    WHERE ID_trainer = NEW.winner;
    
    UPDATE Trainer
    SET exp_points = exp_points + (NEW.exp_reward * 1 / 3)
    WHERE ID_trainer = NEW.loser;
    
	--Si el perdedor es un lider de gimnas, donem el objecte del gimnas al guanyador
    IF loser_is_gym_leader THEN
        SELECT ID_object INTO leader_gym_object
        FROM Gym
        WHERE ID_leader = NEW.loser;
        
        UPDATE Trainer
        SET gift_item = leader_gym_object
        WHERE ID_trainer = NEW.winner;
    END IF;
    
	--Si el guanyador es un malvat, restem la recompensa d'or a la quantitat d'or 
	--que te l'entrenador
    IF winner_is_villain THEN
        UPDATE Trainer
        SET gold = gold - NEW.gold_reward
        WHERE ID_trainer = NEW.loser;
    END IF;
    
    RETURN NEW;
END;
$$
LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS insert_battle_trigger ON Battle;
CREATE TRIGGER insert_battle_trigger
AFTER INSERT ON Battle
FOR EACH ROW
EXECUTE FUNCTION update_trainer();



-- #Validation#
-- if needed, write the validation queries (select, update, inserte, delete)

INSERT INTO Battle (ID_battle, winner, loser, exp_reward, gold_reward)
VALUES(999,0,1,1000,1000);

--trainer_id 500 es el gym_leader del gym amb id_gym 10 i que te el regal amb id_object 193 

INSERT INTO Battle (ID_battle, winner, loser, exp_reward, gold_reward)
VALUES(1001,0,500,1000,1000);