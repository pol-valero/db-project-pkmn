----------------
----------------
-- #Query 5.1#
--

SELECT r.ID_region, r.name
FROM Criminal_Org AS co
JOIN Villain AS v ON co.ID_org = v.ID_org
JOIN Battle AS b ON v.ID_villain = b.winner
JOIN Region AS r ON co.ID_region = r.ID_region
GROUP BY r.ID_region
ORDER BY COUNT(v.ID_villain) DESC
LIMIT 1;


-- #Validation#
-- if needed, write the validation queries (select, update, inserte, delete)


----------------
-- #Query 5.2#
--



-- #Validation#
-- if needed, write the validation queries (select, update, inserte, delete)

----------------
-- #Query 5.3#

UPDATE Pokemon SET obtention_method = 'walk' 
FROM Evolve AS e JOIN Specie AS s 
ON s.ID_specie = e.id_current_specie 
WHERE Pokemon.ID_specie = s.ID_specie 
AND Pokemon.obtention_method LIKE '%only%'; 




-- #Validation#
SELECT s.name FROM Pokemon AS p 
JOIN Specie AS s ON s.ID_specie = p.ID_specie
 WHERE p.obtention_method LIKE '%only%' 
GROUP BY s.name, p.id_specie 
ORDER BY p.id_specie


----------------
-- #Query 5.4#
SELECT t.name FROM Gym AS g
JOIN Trainer AS t ON t.ID_trainer = g.ID_leader
JOIN Team AS team ON team.ID_trainer = t.ID_trainer
JOIN Pokemon AS p ON p.ID_team = team.ID_team
JOIN Specie AS sp ON sp.ID_specie = p.ID_specie
JOIN Pokemon_Types AS pt ON pt.ID_specie = sp.ID_specie AND pt.ID_type <> g.ID_type
JOIN Movement AS m ON m.ID_type <> g.ID_type;

-- #Validation#
-- if needed, write the validation queries (select, update, inserte, delete)

----------------
-- #Query 5.5#
SELECT t.name AS leader_name, o.name AS pokemon_name
FROM Trainer t
JOIN Criminal_Org c ON t.ID_trainer = c.ID_leader
JOIN Trainer_Object tobj ON t.ID_trainer = tobj.ID_trainer
JOIN Object o ON tobj.ID_object = o.ID_object
JOIN Pokemon p ON tobj.ID_trainer = p.ID_trainer
JOIN Pokemon_Movement pm ON p.ID_pokemon = pm.ID_pokemon
JOIN Movement m ON pm.ID_movement = m.ID_movement
WHERE tobj.obtention_method = 'GIFTED'
AND m.name like '%drain%';


-- #Validation#

Per comprovar que aquesta consulta està ben feta s’ha fet diversos SELECT. S’ha comprovat que els objectes siguin obtinguts com ‘GIFTED’, també s’ha mirat que els moviments són de tipus ‘drain’. Així s’ha assegurat que els Pokémon que ens apareixen són correctes.

----------------
-- #Query 5.6#
--
SELECT o.name AS required_object, COUNT(*) AS num_purchases
FROM Trainer t
JOIN Pokemon p ON t.ID_trainer = p.ID_trainer
JOIN Object o ON p.ID_item = o.ID_object
JOIN Specie s ON p.ID_specie = s.ID_specie
WHERE o.ID_object IN (
  		SELECT ID_item
 		FROM Pokemon
  		WHERE ID_trainer = t.ID_trainer
  		GROUP BY ID_item
  		HAVING COUNT(*) >= 1
)
AND s.ID_specie IN (
  		SELECT ID_specie
  		FROM Specie
  		WHERE growth_rate_id IS NOT NULL
)
GROUP BY o.name
ORDER BY num_purchases DESC
LIMIT 1;


-- #Validation#

SELECT t.ID_trainer, t.name AS trainer_name, p.nickname AS pokemon_nickname, o.name AS purchased_object
FROM Trainer t
JOIN Pokemon p ON t.ID_trainer = p.ID_trainer
JOIN Object o ON p.ID_item = o.ID_object
WHERE o.ID_object IN (
 		SELECT ID_item
FROM Pokemon
WHERE ID_trainer = t.ID_trainer
GROUP BY ID_item
HAVING COUNT(*) >= 1
)


----------------
-- #Query 5.7#
SELECT p.id_pokemon, s.name AS especie_name, s.height, s.weight,
    (((2 * ss.base_stat) + (p.level ^ 2 / 4)) / 100) + 5 *
    CASE
        WHEN n.incremented_stat = st.id_stat THEN 1.15
        WHEN n.decremented_stat = st.id_stat THEN 0.85
    END AS final_stat
FROM 
    pokemon p
JOIN nature AS n ON n.id_nature = p.id_nature
JOIN specie s ON p.id_specie = s.id_specie
JOIN specie_stat ss ON s.id_specie = ss.id_specie
JOIN stat st ON ss.id_stat = st.id_stat
WHERE 
    p.datetime >= '2022-09-01' AND p.datetime < '2023-09-01'
ORDER BY 
    p.id_pokemon;


-- #Validation#
-- if needed, write the validation queries (select, update, inserte, delete)

----------------
-- #Query 5.8#
--
SELECT DISTINCT t.ID_trainer, t.name
FROM Trainer AS t
JOIN Pokemon AS p ON t.ID_trainer = p.ID_trainer
JOIN Evolve AS e ON p.ID_specie = e.ID_current_specie
JOIN Area AS a ON e.ID_area = a.ID_area
JOIN City AS c ON a.ID_area = c.ID_city
JOIN Store AS s ON c.ID_city = s.ID_city
JOIN Purchase AS pur ON t.ID_trainer = pur.ID_trainer AND s.ID_store = pur.ID_store; 



-- #Validation#
-- if needed, write the validation queries (select, update, inserte, delete)

