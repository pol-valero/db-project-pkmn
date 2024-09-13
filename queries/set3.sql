----------------
----------------
-- #Query 3.1#
--

SELECT t.name as trainer_name, SUM(p.cost * p.amount) as total_spent, 
	(SELECT o.name
		FROM purchase as p2 
		JOIN object as o
		ON p2.id_object = o.id_object 
		WHERE p2.id_trainer = t.id_trainer 
		GROUP BY p2.id_trainer, p2.id_object, o.name 
		ORDER BY SUM(p2.amount) DESC 
		LIMIT 1
	) as favourite_object 
	FROM trainer as t 
	JOIN purchase as p ON t.id_trainer = p.id_trainer 
	GROUP BY t.id_trainer, t.name 
	ORDER BY total_spent DESC 
	LIMIT 1;


-- #Validation#
-- if needed, write the validation queries (select, update, inserte, delete)
SELECT p.ID_object, o.name, p.amount
	FROM purchase as p
	JOIN object as o ON p.id_object = o.id_object 
	JOIN Trainer as t ON t.id_trainer = p.id_trainer
	WHERE t.name = 'Freeman'
	ORDER BY p.amount DESC;

SELECT t.name, SUM(p.cost * p.amount) as total_spent
	FROM Trainer as t
	JOIN purchase as p ON t.id_trainer = p.id_trainer 
	GROUP BY t.id_trainer, t.name 
	ORDER BY total_spent DESC;

----------------
-- #Query 3.2#
--

SELECT t.ID_trainer, t.name
FROM Trainer AS t
LEFT JOIN Trainer_Object AS tobj ON tobj.ID_trainer = t.ID_trainer
WHERE tobj.ID_object IS NOT NULL
    	AND t.exp_points > 3000
   	AND t.ID_trainer NOT IN (
      		SELECT ID_trainer
        			FROM Purchase
   		)
GROUP BY t.ID_trainer, t.name
HAVING COUNT(DISTINCT tobj.ID_object) > 10;


-- #Validation#
-- if needed, write the validation queries (select, update, inserte, delete)
SELECT t.ID_trainer, t.name
FROM Trainer AS t
FULL OUTER JOIN Trainer_Object AS tobj ON tobj.ID_trainer = t.ID_trainer
WHERE tobj.ID_object IS NOT NULL
    	AND t.ID_trainer NOT IN (
        	SELECT ID_trainer
        		FROM Purchase
    	)
GROUP BY t.ID_trainer, t.name;

----------------
-- #Query 3.3#
--

SELECT bf2.name
	FROM Berry_Flavour AS bf2
	WHERE bf2.id_flavour = (
	SELECT bf.id_flavour
		FROM Store_Object as so
		JOIN Berry as b on b.id_berry = so.id_object
		JOIN Berry_BerryFlavour as bbf on bbf.ID_berry = b.id_berry
		JOIN Berry_Flavour as bf on bf.id_flavour = bbf.ID_flavour
		GROUP BY bf.id_flavour
		ORDER BY COUNT(bbf.id_flavour) ASC
		LIMIT 1
);


-- #Validation#
-- if needed, write the validation queries (select, update, inserte, delete)
SELECT b.id_berry, bbf.id_flavour, bf.name FROM Store_Object as so
	JOIN Berry as b on b.id_berry = so.id_object
	JOIN Berry_BerryFlavour as bbf on bbf.ID_berry = b.id_berry
	JOIN Berry_Flavour as bf on bf.id_flavour = bbf.id_flavour
	-- WHERE bf.name = 'bitter' -- 49
	-- WHERE bf.name = 'dry'	-- 54
	-- WHERE bf.name = 'sour'	-- 41
	-- WHERE bf.name = 'spicy'	-- 45
	-- WHERE bf.name = 'sweet'	-- 54
	ORDER BY bf.name;

----------------
-- #Query 3.4#
--

SELECT o.ID_object, o.name,  
COUNT(sb.ID_object) AS total_store_objects, 
    	COUNT(tobj.ID_object) AS total_trainer_objects,
    	COUNT(so.ID_object) AS total_sales
	FROM Object AS o
	LEFT JOIN Store_Object AS so ON so.id_object = o.ID_object
	LEFT JOIN Purchase AS sb ON sb.ID_object = o.ID_object
	LEFT JOIN Trainer_Object AS tobj ON tobj.ID_object = o.ID_object
	GROUP BY o.ID_object, o.name
ORDER BY ( COUNT(sb.ID_object) + COUNT(tobj.ID_object) + COUNT(so.ID_object) ) ASC
	LIMIT 1;

-- #Validation#
-- if needed, write the validation queries (select, update, inserte, delete)
SELECT o.ID_object, o.name,  
    COUNT(sb.ID_object) AS total_store_objects
	FROM Object AS o
	LEFT JOIN Purchase AS sb ON sb.ID_object = o.ID_object
	WHERE o.name = 'scope lens'
	GROUP BY o.ID_object, o.name
	ORDER BY ( COUNT(sb.ID_object)) ASC;

SELECT o.ID_object, o.name,  
    COUNT(tobj.ID_object) AS total_trainer_objects
	FROM Object AS o
	LEFT JOIN Trainer_Object AS tobj ON tobj.ID_object = o.ID_object
	WHERE o.name = 'scope lens'
	GROUP BY o.ID_object, o.name
	ORDER BY COUNT(tobj.ID_object) ASC;

SELECT o.ID_object, o.name,  
    COUNT(so.ID_object) AS total_sales
	FROM Object AS o
	LEFT JOIN Store_Object AS so ON so.id_object = o.ID_object
	WHERE o.name = 'scope lens'
	GROUP BY o.ID_object, o.name
	ORDER BY COUNT(so.ID_object) ASC;

----------------
-- #Query 3.5#
--
SELECT SUM(p.amount * p.cost * p.discount)
	FROM purchase as p
	WHERE EXTRACT(YEAR FROM p.date_time) = 2020;


-- #Validation#
-- if needed, write the validation queries (select, update, inserte, delete)
SELECT p.amount, p.cost, p.discount, (p.amount * p.cost * p.discount) AS total_discount
FROM purchase AS p
WHERE EXTRACT(YEAR FROM p.date_time) = 2020 AND  (p.amount * p.cost * p.discount)  <> 0;

----------------
-- #Query 3.6.1#
--
SELECT *
	FROM Berry AS b
	WHERE b.id_berry = (
	SELECT b.id_berry
	FROM Trainer_Object as train_o
	JOIN Berry as b on b.id_berry = train_o.id_object
	GROUP BY b.id_berry
	ORDER BY COUNT(b.id_berry) DESC
	LIMIT 1
);



-- #Validation#
-- if needed, write the validation queries (select, update, inserte, delete)

----------------
-- #Query 3.6.2#
--
SELECT *
	FROM Berry AS b
	WHERE b.id_berry = (
	SELECT train_o.id_object
	FROM Trainer_Object AS train_o
	JOIN Berry AS b ON b.id_berry = train_o.id_object
	GROUP BY train_o.id_object
	ORDER BY COUNT(train_o.id_object) DESC
	LIMIT 1
);



-- #Validation#
-- if needed, write the validation queries (select, update, inserte, delete)
SELECT b.id_berry, COUNT(b.id_berry) as conreu_count
FROM Trainer_Object as train_o
JOIN Berry as b ON b.id_berry = train_o.id_object
GROUP BY b.id_berry
ORDER BY conreu_count DESC;

----------------
-- #Trigger 3.1#
--
DROP TRIGGER IF EXISTS heal_pokemon_trigger ON Object;

CREATE OR REPLACE FUNCTION heal_pokemon()
RETURNS TRIGGER AS $$
DECLARE
    max_hp INTEGER;
    healing_amount INTEGER;
    pokemon_id INTEGER;
BEGIN
    SELECT ID_pokemon INTO pokemon_id
    FROM Pokemon
    WHERE ID_trainer = (SELECT ID_trainer FROM Trainer ORDER BY ID_trainer LIMIT 1)
    LIMIT 1;

    SELECT (2 * (p.remaining_health + (p.level^2 / 4) / 100) + 5) * n.incremented_stat
    INTO max_hp
    FROM Pokemon p
    INNER JOIN Nature n ON p.ID_nature = n.ID_nature
    WHERE p.ID_pokemon = pokemon_id;

    SELECT healing
    INTO healing_amount
    FROM Healing_Item
    WHERE ID_healing_item = OLD.ID_healing_item;

    IF (SELECT remaining_health FROM Pokemon WHERE ID_pokemon = pokemon_id) < max_hp THEN
        UPDATE Pokemon
        SET remaining_health = remaining_health + healing_amount
        WHERE ID_pokemon = pokemon_id;

        
        UPDATE Pokemon
        SET remaining_health = max_hp
        WHERE ID_pokemon = pokemon_id AND remaining_health > max_hp;
    END IF;

    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER heal_pokemon_trigger
AFTER DELETE OR UPDATE ON Object
FOR EACH ROW
EXECUTE FUNCTION heal_pokemon();



-- #Validation#
-- if needed, write the validation queries (select, update, inserte, delete)
DELETE from Pokemon as pok where pok.nickname = 'Pikachu';
INSERT INTO Pokemon (ID_pokemon, nickname, level, ID_trainer, ID_team, ID_nature, remaining_health)
VALUES (13715,'Pikachu', 50, 1, 1, 1, 23);

INSERT INTO Healing_Item (ID_Healing_item, description, healing)
VALUES (100, 'Potion', 20);

DELETE FROM Healing_Item
WHERE description = 'Potion';

SELECT remaining_health
FROM Pokemon
WHERE ID_trainer = 1
AND ID_team = 1;

SELECT * from Pokemon as pok where pok.nickname = 'Pikachu';

----------------
-- #Trigger 3.2#
--
CREATE OR REPLACE FUNCTION process_purchase()
RETURNS TRIGGER AS $$
DECLARE
    trainer_id INTEGER;
    item_name VARCHAR(255);
    store_name VARCHAR(255);
    store_city_name VARCHAR(255);
    gold_cost INTEGER;
    item_id INTEGER;
    item_stock INTEGER;
    trainer_gold INTEGER;
BEGIN
    -- Obtenir les dades necessàries de la compra
    SELECT p.ID_trainer, o.name, s.name, a.name, o.cost
    INTO trainer_id, item_name, store_name, store_city_name, gold_cost
    FROM Purchase p
    INNER JOIN Object o ON p.ID_object = o.ID_object
    INNER JOIN Store s ON p.ID_store = s.ID_store
    INNER JOIN City c ON s.ID_city = c.ID_city
    INNER JOIN Area a ON c.ID_city = a.ID_area
    WHERE p.ID_purchase = NEW.ID_purchase;

    -- Obtenir l'estoc de l'objecte a la botiga
    SELECT stock
    INTO item_stock
    FROM Store_Object
    WHERE ID_store = NEW.ID_store AND ID_object = NEW.ID_object;

    -- Obtenir la quantitat d'or de l'entrenador comprador
    SELECT gold
    INTO trainer_gold
    FROM Trainer
    WHERE ID_trainer = trainer_id;

    -- Comprovar si hi ha suficient estoc i or per realitzar la compra
    IF item_stock >= NEW.amount AND trainer_gold >= gold_cost * NEW.amount THEN
        -- Actualitzar la quantitat d'or de l'entrenador comprador
        UPDATE Trainer
        SET gold = trainer_gold - gold_cost * NEW.amount
        WHERE ID_trainer = trainer_id;

        -- Actualitzar l'estoc de l'objecte a la botiga
        UPDATE Store_Object
        SET stock = item_stock - NEW.amount
        WHERE ID_store = NEW.ID_store AND ID_object = NEW.ID_object;

        -- Comprovar si l'objecte ja existeix a la motxilla del jugador
        SELECT ID_object
        INTO item_id
        FROM Trainer_Object
        WHERE ID_trainer = trainer_id AND ID_object = NEW.ID_object;

        -- Si l'objecte ja existeix, actualitzar la quantitat
        IF FOUND THEN
            UPDATE Trainer_Object
            SET amount = amount + NEW.amount
            WHERE ID_trainer = trainer_id AND ID_object = NEW.ID_object;
        -- Si l'objecte no existeix, printar missatge
        ELSE
            INSERT INTO Trainer_Object (ID_trainer, ID_object, amount)
            VALUES (trainer_id, NEW.ID_object, NEW.amount);
        END IF;
    -- Si no hi ha suficient estoc a la botiga, printar missatge
    ELSEIF item_stock < NEW.amount THEN
    	RAISE NOTICE 'Trainer #% tried to buy % but his card has been declined, insufficient funds.', trainer_id, item_name;
    -- Si no hi ha suficient or a la motxilla de l'entrenador, printar missatge
    ELSE
        RAISE NOTICE 'Trainer #% tried to buy % but his card has been declined, insufficient funds.', trainer_id, item_name;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;



-- #Validation#
-- if needed, write the validation queries (select, update, inserte, delete)
-- Insertar una compra a la taula Purchase
INSERT INTO Purchase (cost, ID_trainer, ID_object, ID_store, discount, date_time, amount)
VALUES (100, 1, 1, 1, 0, CURRENT_DATE, 1);


-- Consulta per comprovar els canvis realitzats
SELECT * FROM Trainer WHERE id_trainer = 1;
SELECT * FROM Store_Object WHERE id_store = 1 AND id_object = 1;
SELECT * FROM Trainer_Object WHERE id_trainer = 1 AND id_object = 1;


