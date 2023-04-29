DROP TABLE IF EXISTS type_aux;
CREATE TABLE IF NOT EXISTS type_aux (
    id INTEGER,
    name VARCHAR (255)
);

COPY type_aux (id,name)
FROM '/Users/Shared/BBDD-DATASETS/types.csv'
DELIMITER ','
CSV HEADER; 

DROP TABLE IF EXISTS abilities_aux;
CREATE TABLE IF NOT EXISTS abilities_aux (
    id INTEGER,
    name VARCHAR(255),
    effect TEXT,
    short_effect VARCHAR (255)
);

COPY abilities_aux (id,name, effect, short_effect)
FROM '/Users/Shared/BBDD-DATASETS/abilities.csv'
DELIMITER ','
CSV HEADER; 


DROP TABLE IF EXISTS damage_relations_aux;
CREATE TABLE IF NOT EXISTS damage_relations_aux (
    attacker VARCHAR (255),
    defender VARCHAR (255),
    multiplier VARCHAR (5)
);

COPY damage_relations_aux (attacker,defender, multiplier)
FROM '/Users/Shared/BBDD-DATASETS/damage_relations.csv'
DELIMITER ','
CSV HEADER; 

DROP TABLE IF EXISTS evolutions_aux;
CREATE TABLE IF NOT EXISTS evolutions_aux (
    baseID VARCHAR (255), 
    evolutionID VARCHAR (255), 
    is_baby BOOLEAN, 
    trigger VARCHAR (255), 
    gender VARCHAR (255), 
    min_level INTEGER,
    time_of_day VARCHAR(255),
    location VARCHAR(255),
    item VARCHAR (255), 
    known_move VARCHAR (255),
    min_happiness VARCHAR(255)
);

COPY evolutions_aux (baseID,evolutionID, is_baby,trigger, gender, min_level, time_of_day, location, item, known_move, min_happiness)
FROM '/Users/Shared/BBDD-DATASETS/evolutions.csv'
DELIMITER ','
CSV HEADER;

DROP TABLE IF EXISTS growth_rates_aux;
CREATE TABLE IF NOT EXISTS growth_rates_aux (
    id INTEGER,
    name VARCHAR (255),
    formula TEXT,
    level INTEGER, 
    experience BIGINT
);

COPY growth_rates_aux (id,name, formula, level, experience)
FROM '/Users/Shared/BBDD-DATASETS/growth_rates.csv'
DELIMITER ','
CSV HEADER; 


DROP TABLE IF EXISTS pokemon_abilities_aux;
CREATE TABLE IF NOT EXISTS pokemon_abilities_aux (
    spiecesID INTEGER,
    abilityID INTEGER,
    slot INT, 
    is_hidden BOOLEAN 
);

COPY pokemon_abilities_aux (spiecesID, abilityID, slot, is_hidden)
FROM '/Users/Shared/BBDD-DATASETS/pokemon_abilities.csv'
DELIMITER ','
CSV HEADER; 


DROP TABLE IF EXISTS pokemon_aux;
CREATE TABLE IF NOT EXISTS pokemon_aux (
    index INTEGER,
    pokemon VARCHAR (255),
    baseExperience INTEGER, 
    height INT, 
    weight INT, 
    dex_order INTEGER, 
    growth_rate_ID INT, 
    type1 VARCHAR(100),
    type2 VARCHAR(100)
);

COPY pokemon_aux (index,pokemon, baseExperience, height, weight, dex_order, growth_rate_ID, type1, type2)
FROM '/Users/Shared/BBDD-DATASETS/pokemon.csv'
DELIMITER ','
CSV HEADER;

-- Gym

DROP TABLE IF EXISTS aux_gyms;
CREATE TABLE IF NOT EXISTS aux_gyms (
    leader VARCHAR(255),
    location VARCHAR(255),
	type VARCHAR(255),
	badge VARCHAR(255),
	name VARCHAR(255)
);

COPY aux_gyms FROM '/Users/Shared/BBDD-DATASETS/gyms.csv'
DELIMITER ','
CSV HEADER;


-- Encounters
DROP TABLE IF EXISTS aux_encounters;
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
	
COPY aux_encounters FROM '/Users/Shared/BBDD-DATASETS/encounters.csv'
DELIMITER ','
CSV HEADER;

-- Locations
DROP TABLE IF EXISTS aux_locations;
CREATE TABLE IF NOT EXISTS aux_locations (
    region VARCHAR(255),
    area VARCHAR(255),
	subarea VARCHAR(255),
	subareaID INTEGER,
	population INTEGER
);
	
COPY aux_locations FROM '/Users/Shared/BBDD-DATASETS/locations.csv'
DELIMITER ','
CSV HEADER;

-- Routes
DROP TABLE IF EXISTS aux_routes;
CREATE TABLE IF NOT EXISTS aux_routes (
    Route VARCHAR(255),
    North VARCHAR(255),
	East VARCHAR(255),
	West VARCHAR(255),
	South VARCHAR(255),
	Pavement VARCHAR(255)
);
	
COPY aux_routes FROM '/Users/Shared/BBDD-DATASETS/routes.csv'
DELIMITER ','
CSV HEADER;

DROP TABLE IF EXISTS battle_statistics_aux;
CREATE TABLE IF NOT EXISTS battle_statistics_aux (
    battleID INTEGER,
    pokemon_instanceID INTEGER,
	remaining_hp INTEGER, 
	damage_received INTEGER, 
	damage_dealt INTEGER
);

COPY battle_statistics_aux FROM '/Users/Shared/BBDD-DATASETS/battle_statistics.csv' 
DELIMITER ','
CSV HEADER;

DROP TABLE IF EXISTS battles_aux;
CREATE TABLE IF NOT EXISTS battles_aux (
    battleID INTEGER,
    winnerID INTEGER,
	loserID INTEGER, 
	date_time TIMESTAMP, 
	gold_reward INTEGER,
	experience INTEGER,
	duration INTEGER
);

COPY battles_aux FROM '/Users/Shared/BBDD-DATASETS/battles.csv' 
DELIMITER ','
CSV HEADER;


DROP TABLE IF EXISTS natures_aux;
CREATE TABLE IF NOT EXISTS natures_aux (
    name VARCHAR(255),
    id INTEGER,
	decreased_stat VARCHAR(255),
	increased_stat VARCHAR(255),
	likes_flavor VARCHAR(255),
	hates_flavor VARCHAR(255)
);

COPY natures_aux FROM '/Users/Shared/BBDD-DATASETS/natures.csv' 
DELIMITER ','
CSV HEADER;


DROP TABLE IF EXISTS poketeams_aux;
CREATE TABLE IF NOT EXISTS poketeams_aux (
    trainer INTEGER,
    pokemon INTEGER,
	slot INTEGER, 
	hp INTEGER, 
	status VARCHAR(255)
);

COPY poketeams_aux FROM '/Users/Shared/BBDD-DATASETS/poketeams.csv' 
DELIMITER ','
CSV HEADER;


DROP TABLE IF EXISTS trainers_aux;
CREATE TABLE IF NOT EXISTS trainers_aux (
    id INTEGER,
    trainer_class VARCHAR(255),
	name VARCHAR(255), 
	experience INTEGER, 
	gold INTEGER,
	gift_item VARCHAR(255),
	villain_team VARCHAR(255),
	partnerID INTEGER,
	phrase VARCHAR(255),
	money_stolen DECIMAL
);

COPY trainers_aux FROM '/Users/Shared/BBDD-DATASETS/trainers.csv' 
DELIMITER ','
CSV HEADER;

-- PURCHASES
DROP TABLE IF EXISTS purchases_aux;
CREATE TABLE IF NOT EXISTS purchases_aux (
    storeID INTEGER,
    trainerID INTEGER,
    itemID INTEGER,
    amount INTEGER,
    cost INTEGER,
    discount INTEGER,
    date_time DATE
);

COPY purchases_aux(storeID, trainerID, itemID, amount, cost, discount, date_time)
FROM '/Users/Shared/BBDD-DATASETS/purchases.csv'
DELIMITER ','
CSV HEADER;

-- STORES
DROP TABLE IF EXISTS stores_aux;
CREATE TABLE IF NOT EXISTS stores_aux (
    storeID INTEGER,
    store_name TEXT,
    floors INTEGER,
    city TEXT
);
COPY stores_aux(storeID, store_name, floors, city)
FROM '/Users/Shared/BBDD-DATASETS/stores.csv'
DELIMITER ','
CSV HEADER;

-- STOREITEMS
DROP TABLE IF EXISTS store_items_aux;
CREATE TABLE IF NOT EXISTS store_items_aux (
    storeID INTEGER,
    itemID INTEGER,
    stock INTEGER,
    discount INTEGER
);
COPY store_items_aux(storeID, itemID, stock, discount)
FROM '/Users/Shared/BBDD-DATASETS/storeitems.csv'
DELIMITER ','
CSV HEADER;

-- ITEMS
DROP TABLE IF EXISTS items_aux;
CREATE TABLE IF NOT EXISTS items_aux (
    id INTEGER,
    name VARCHAR(255),
    cost INTEGER,
    effect TEXT,
    healing VARCHAR(255),
    can_revive BOOLEAN,
    statistic VARCHAR(255),
    stat_increase_time INTEGER,
    top_capture_rate INTEGER,
    min_capture_rate INTEGER,
    quick_sell_price INTEGER,
    collector_price INTEGER,
    move VARCHAR(255)
);

COPY items_aux(id, name, cost, effect, healing, can_revive, statistic, stat_increase_time, top_capture_rate, min_capture_rate, quick_sell_price, collector_price, move)
FROM '/Users/Shared/BBDD-DATASETS/items.csv'
DELIMITER ','
CSV HEADER;

DROP TABLE IF EXISTS berries_aux;
CREATE TABLE IF NOT EXISTS berries_aux (
    id INTEGER,
    name VARCHAR(255),
    growth_time INTEGER,
    max_num_harvest INTEGER,
    natural_gift_powder INTEGER,
    berry_avg_size INTEGER,
    smoothness INTEGER,
    soil_dryness INTEGER,
    firmness VARCHAR(255)
);

COPY berries_aux(id, name, growth_time, max_num_harvest, natural_gift_powder, berry_avg_size, smoothness, soil_dryness, firmness)
FROM '/Users/Shared/BBDD-DATASETS/berries.csv'
DELIMITER ','
CSV HEADER;

DROP TABLE IF EXISTS berries_flavours_aux;
CREATE TABLE IF NOT EXISTS berries_flavours_aux (
    berry VARCHAR(255),
    flavour VARCHAR(255),
    potency INTEGER
);

COPY berries_flavours_aux(berry, flavour, potency)
FROM '/Users/Shared/BBDD-DATASETS/berries_flavours.csv'
DELIMITER ','
CSV HEADER;


DROP TABLE IF EXISTS moves_aux;
CREATE TABLE IF NOT EXISTS moves_aux (
    move_id INTEGER,
    name VARCHAR(255),
	accuracy INTEGER, 
	effect VARCHAR(255), 
	pp INTEGER,
	priority INTEGER,
	target VARCHAR(255),
	type VARCHAR(255), 
	move_damage_class VARCHAR(255),
	hp_healing INTEGER,
	hp_drain INTEGER,
	power INTEGER,
	flinch_chance INTEGER,
	min_hits INTEGER,
	max_hits INTEGER,
	ailment VARCHAR(255),
	ailment_chance INTEGER,
	stat VARCHAR(255),
	stat_change_rate INTEGER,
	change_amount INTEGER
);

COPY moves_aux FROM '/Users/Shared/BBDD-DATASETS/moves.csv' 
DELIMITER ',' CSV HEADER;


DROP TABLE IF EXISTS trainer_items_aux;
CREATE TABLE IF NOT EXISTS trainer_items_aux (
    trainerID INTEGER,
    itemID INTEGER,
	obtention_method VARCHAR(255), 
	date_time TIMESTAMP
);

COPY trainer_items_aux FROM '/Users/Shared/BBDD-DATASETS/traineritems.csv' 
DELIMITER ',' CSV HEADER;


DROP TABLE IF EXISTS villainous_organizations_aux;
CREATE TABLE IF NOT EXISTS villainous_organizations_aux (
    name VARCHAR(255),
    building VARCHAR(255),
	hq VARCHAR(255), 
	leader VARCHAR(255),
	region VARCHAR(255)
);

COPY villainous_organizations_aux FROM '/Users/Shared/BBDD-DATASETS/villainous_organizations.csv'
DELIMITER ',' CSV HEADER;

DROP TABLE IF EXISTS stats_aux;
CREATE TABLE IF NOT EXISTS stats_aux (
    stat VARCHAR(255),
    pokemon VARCHAR(255),
	base_stat INTEGER,
	effort INTEGER
);

COPY stats_aux FROM '/Users/Shared/BBDD-DATASETS/stats.csv' 
DELIMITER ',' CSV HEADER;


DROP TABLE IF EXISTS pokemon_instances_aux;
CREATE TABLE IF NOT EXISTS pokemon_instances_aux (
    id INT,
	pokemon_speciesID INT,
	nickname VARCHAR(255),
	ownerID INT,
	level INT, 
	experience INT,
	gender VARCHAR (255),
	nature VARCHAR (255),
	item VARCHAR (255),
	datetime TIMESTAMP, 
	location_subareaID INT,
	obtention_method VARCHAR(255),
	pokeballID VARCHAR(255),
	move1 INT,
	move2 INT,
	move3 INT,
	move4 INT
);

COPY pokemon_instances_aux
FROM '/Users/Shared/BBDD-DATASETS/pokemon_instances.csv'
DELIMITER ','
CSV HEADER;


INSERT INTO ability SELECT * FROM abilities_aux;


INSERT INTO Types SELECT * FROM Type_aux;


INSERT INTO Relation (ID_type1, ID_type2, multiplier)
SELECT t1.id_type, t2.id_type, d.multiplier
FROM Types t1, Types t2, damage_relations_aux AS d
WHERE t1.name = d.attacker
AND t2.name = d.defender;


INSERT INTO Growth_rates (id_growth_rate, name, formula) SELECT DISTINCT id, name, formula
FROM growth_rates_aux;

INSERT INTO Level (id_level) SELECT DISTINCT level
FROM growth_rates_aux;

INSERT INTO growth_level (id_level, id_growth_rate, experience)
SELECT l.id_level, g.id_growth_rate, gr.experience
FROM growth_rates_aux gr
JOIN Growth_Rates as g ON gr.id = g.id_growth_rate
JOIN Level AS l ON gr.level = l.id_level;


INSERT INTO Stat (stat_name) SELECT DISTINCT stat
FROM stats_aux;


INSERT INTO Region(name)
SELECT DISTINCT(region)
FROM aux_locations;


INSERT INTO Area(name, ID_region)
SELECT loc.area, r.ID_region
FROM aux_locations AS loc
JOIN Region AS r ON r.name = loc.region
GROUP BY r.ID_region, loc.area;


INSERT INTO Pavement(type)
SELECT (r.pavement) FROM aux_routes AS r
GROUP BY r.pavement;


INSERT INTO Cardinal_Point(name)
VALUES ('North'), ('East'), ('West'), ('South');


INSERT INTO Route(ID_route, km_length, ID_pavement)
SELECT a.ID_area, FLOOR(RANDOM() * 1000), p.id_pavement 
FROM Area AS a
JOIN aux_routes AS r ON LOWER(r.route)= LOWER(a.name)
JOIN pavement AS p ON p.type = r.pavement
GROUP BY a.ID_area, p.id_pavement;


INSERT INTO Route_Area(ID_area, ID_route, ID_cardinal_point_route)
SELECT area_north.ID_area, route.ID_area, cp.ID_cardinal_point
FROM aux_routes AS ar
JOIN Area AS area_north ON LOWER(area_north.name) = LOWER(ar.north) 
JOIN Area AS route ON LOWER(route.name) = LOWER(ar.route)
JOIN Cardinal_Point AS cp ON cp.name = 'North'

UNION ALL

SELECT area_east.ID_area, route.ID_area, cp.ID_cardinal_point
FROM aux_routes AS ar
JOIN Area AS area_east ON LOWER(area_east.name) = LOWER(ar.east) 
JOIN Area AS route ON LOWER(route.name) = LOWER(ar.route)
JOIN Cardinal_Point AS cp ON cp.name = 'East'

UNION ALL

SELECT area_west.ID_area, route.ID_area, cp.ID_cardinal_point
FROM aux_routes AS ar
JOIN Area AS area_west ON LOWER(area_west.name) = LOWER(ar.west) 
JOIN Area AS route ON LOWER(route.name) = LOWER(ar.route)
JOIN Cardinal_Point AS cp ON cp.name = 'West'

UNION ALL

SELECT area_south.ID_area, route.ID_area, cp.ID_cardinal_point
FROM aux_routes AS ar
JOIN Area AS area_south ON LOWER(area_south.name) = LOWER(ar.south) 
JOIN Area AS route ON LOWER(route.name) = LOWER(ar.route)
JOIN Cardinal_Point AS cp ON cp.name = 'South';


INSERT INTO Badge(name)
SELECT DISTINCT(badge)
FROM aux_gyms;


INSERT INTO Object (id_object, name, cost, effect)
SELECT 
	items_aux.id,
    items_aux.name, 
    items_aux.cost, 
    items_aux.effect
FROM items_aux;


INSERT INTO Trainer(ID_trainer, name, exp_points, gold, class, gift_item)
SELECT ta.id, ta.name, ta.experience, ta.gold, ta.trainer_class, o.ID_object
FROM trainers_aux as ta
LEFT JOIN Object as o on o.name = ta.gift_item;
UPDATE Trainer
SET name = REPLACE(REPLACE(name, E'\n', ''), E'\r', ''); 


INSERT INTO Specie (ID_specie, name, base_experience, height, weight, dex_order, growth_rate_id)
SELECT index, pokemon, baseexperience,  height, weight, dex_order, growth_rate_id
FROM pokemon_aux;


INSERT INTO Specie_Ability(id_specie, id_ability, slot, is_hidden)
SELECT spiecesid, abilityid, slot, is_hidden 
FROM pokemon_abilities_aux;

INSERT INTO Gym_Leader(ID_gym_leader)
SELECT t.id_trainer
FROM aux_gyms AS g 
JOIN Trainer AS t ON g.leader = t.name 
WHERE t.class LIKE '%Gym Leader%';

-- Fill the Gyms table and insert a random Object ID contained in the Object table
INSERT INTO Gym(name, ID_badge, ID_leader, ID_type, ID_Object)
SELECT ag.name, b.ID_badge, tr.ID_trainer, ty.ID_type, 
  (SELECT ID_object FROM (
    SELECT ID_object, ROW_NUMBER() OVER () as ro
    FROM Object
  ) AS o
  WHERE ro = FLOOR((RANDOM() * (SELECT COUNT(*) FROM Object)) + 1)) AS random_object
FROM aux_gyms AS ag
JOIN Badge AS b ON b.name = ag.badge
JOIN Trainer AS tr ON tr.name = ag.leader
JOIN Gym_Leader AS gl ON gl.id_gym_leader = tr.id_trainer
JOIN Types AS ty ON LOWER(ty.name) = LOWER(ag.type);

INSERT INTO City(ID_city, population)
SELECT DISTINCT a.ID_area, population
FROM aux_locations AS loc
JOIN Area AS a ON a.name = loc.area
JOIN Region AS r ON loc.region = r.name
WHERE a.ID_region = r.ID_region AND loc.population IS NOT NULL;

-- Fill the City with the gyms
UPDATE City AS c
SET ID_gym = g.ID_gym
FROM aux_gyms AS ag
JOIN Area AS a ON LOWER(a.name) = LOWER(ag.location)
JOIN Gym AS g ON g.name = ag.name
WHERE c.ID_city = a.ID_area;

INSERT INTO Trainer_Badge(ID_trainer, ID_badge)
SELECT 
    t.ID_Trainer, 
    FLOOR(((RANDOM() * (SELECT MAX(ID_badge) FROM Badge)) - (SELECT MIN(ID_badge) FROM Badge) + 1)) + (SELECT MIN(ID_badge) FROM Badge) AS random_Badge 
FROM Trainer t;

INSERT INTO Subarea(ID_subarea, name, ID_area)
SELECT loc.subareaID, loc.subarea, a.ID_area
FROM aux_locations AS loc
JOIN Area AS a ON a.name = loc.area
JOIN Region AS r ON r.name = loc.region
WHERE loc.subarea IS NOT NULL AND a.ID_region = r.ID_region
ORDER BY loc.subareaID ASC;
