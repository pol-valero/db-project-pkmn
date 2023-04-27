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
	pokeballID VARCHAR (255),
	move1 INT,
	move2 INT,
	move3 INT,
	move4 INT
);

COPY pokemon_instances_aux
FROM '/Users/Shared/BBDD-DATASETS/pokemon_instances.csv'
DELIMITER ','
CSV HEADER;





-------------------------------------INSERTS-------------------------------------



DELETE FROM Ability;
DELETE FROM Types;
DELETE FROM Relation;
DELETE FROM Growth_Rates;
DELETE FROM Stat;
DELETE FROM Region;
DELETE FROM Area;
DELETE FROM Pavement;
DELETE FROM Route;
DELETE FROM Route_Area;
DELETE FROM Badge;
DELETE FROM Object;
DELETE FROM Trainer;
DELETE FROM Gym_Leader;
DELETE FROM Specie;
DELETE FROM Specie_Ability;
DELETE FROM Gym;
DELETE FROM City;
DELETE FROM Trainer_Badge;
DELETE FROM Subarea;
DELETE FROM Encounter_Method;
DELETE FROM Condition_Type;
DELETE FROM Specie_Subarea_Condition_Method;
DELETE FROM Trainer_Gym;
DELETE FROM Berry;
DELETE FROM Berry_Flavour;
DELETE FROM Berry_BerryFlavour;
DELETE FROM Collector;
DELETE FROM Loot;
DELETE FROM Healing_Item;
DELETE FROM Pokeball;
DELETE FROM Boosting;
DELETE FROM Movement;
DELETE FROM Technical_Machine;
DELETE FROM Store;
DELETE FROM Store_Object;
DELETE FROM Sale;
DELETE FROM Purchase;
DELETE FROM Pokemon;
DELETE FROM Pokemon_Object;
DELETE FROM Battle;
DELETE FROM Battle_Result;
DELETE FROM Nature;
DELETE FROM Team;
DELETE FROM Villain;
DELETE FROM Criminal_Org;
DELETE FROM Trainer_Object;
DELETE FROM Trainer_Defeats_Gym;
DELETE FROM Damage;
DELETE FROM Curation;
DELETE FROM State;
DELETE FROM Pokemon_Movement;
DELETE FROM Pokemon_Stat;
DELETE FROM Pokemon_Types;
DELETE FROM Evolve;



INSERT INTO ability SELECT * FROM abilities_aux;


INSERT INTO Types SELECT * FROM Type_aux;


ALTER TABLE Relation DROP CONSTRAINT Relation_pkey;
INSERT INTO Relation (ID_type1, ID_type2, multiplier)
SELECT t1.id_type, t2.id_type, d.multiplier
FROM Types t1, Types t2, damage_relations_aux AS d
WHERE t1.name = d.attacker
AND t2.name = d.defender;


ALTER TABLE growth_rates DROP CONSTRAINT growth_rates_pkey CASCADE;
INSERT INTO growth_rates SELECT * FROM growth_rates_aux;


INSERT INTO Stat (stat_name) SELECT DISTINCT stat
FROM stats_aux;


INSERT INTO Region(name)
SELECT DISTINCT(region)
FROM aux_locations;


INSERT INTO Area(name, ID_region)
SELECT (loc.area, r.ID_region)
FROM aux_locations AS loc
JOIN Region AS r ON r.name = loc.region
GROUP BY loc.area, r.ID_region;


INSERT INTO Pavement(type)
SELECT (r.pavement) FROM aux_routes AS r
GROUP BY r.pavement;


INSERT INTO Route(ID_route, km_length, ID_pavement)
SELECT DISTINCT(a.ID_area), NULL, p.id_pavement FROM Area AS a
JOIN aux_locations AS loc ON loc.area = a.name
JOIN aux_routes AS r ON LOWER(r.route)= LOWER(a.name)
JOIN pavement AS p ON p.type = r.pavement;


--Here we should put the Route_Area INSERT


INSERT INTO Badge(nom)
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
SELECT id, name, experience, gold, trainer_class, gift_item
FROM trainers_aux;


INSERT INTO Gym_Leader(ID_gym_leader)
SELECT t.id
FROM gyms_aux AS g 
JOIN trainers_aux AS t ON g.leader = t.name;


INSERT INTO Specie (ID_specie, name, base_experience, height, weight, dex_order, growth_rate_id)
SELECT index, pokemon, baseexperience,  height, weight, dex_order, growth_rate_id
FROM pokemon_aux;


INSERT INTO specie_ability (id_specie, id_ability, slot, is_hidden)
SELECT spiecesid, abilityid, slot, is_hidden 
FROM pokemon_abilities_aux;


--Here we should put the Gym INSERT


INSERT INTO City (ID_city, ID_gym, population)
SELECT (loc.area, g.name, population) FROM aux_locations AS loc
JOIN Area AS a ON a.name = loc.area
JOIN aux_gyms AS aux_g ON aux_g.location = a.name
JOIN Gym AS g ON g.name = aux_g.name
WHERE loc.population IS NOT NULL;


--Here we should put the Trainer_Badge INSERT


INSERT INTO Subarea(ID_subarea, name, ID_area)
SELECT (loc.subareaID, loc.subarea, a.ID_area)
FROM aux_locations AS loc
JOIN Area AS a ON a.name = loc.area
JOIN Region AS r ON r.name = loc.region
WHERE loc.subarea IS NOT NULL AND a.ID_region = r.ID_region
ORDER BY loc.subareaID ASC;


INSERT INTO Encounter_Method(method_type)
SELECT DISTINCT(method) FROM aux_encounters


INSERT INTO Condition_Type(condition_type, condition_value)
SELECT condition_type, condition_value FROM aux_encounters
GROUP BY condition_type, condition_value;


INSERT INTO Specie_Subarea_Condition_Method (ID_subarea, ID_method, ID_specie, chance, min_level_specie, max_level_specie)
SELECT (subareid, m.ID_method, s.ID_specie, chance, min_level, max_level, c.ID_condition) FROM aux_encounters
JOIN Method AS m ON m.method_type = method
JOIN Condition_Type AS c ON c.condition_type = condition_type AND c.condition_value = condition_value
JOIN Specie AS s ON s.name = pokemon;


--Here we should put the Trainer_Gym INSERT


INSERT INTO Berry(ID_berry, name, growth_time, max_num_harvest, natural_gift_powder, berry_avg_size, smoothness, soil_dryness, firmness)
SELECT  id, name, growth_time, max_num_harvest, natural_gift_powder, berry_avg_size, smoothness, soil_dryness, firmness
FROM berries_aux;


INSERT INTO Berry_Flavour(name, potency)
SELECT  flavour, potency
FROM berries_flavours_aux;


--Here we should put the Berry_BerryFlavour INSERT


INSERT INTO Collector(collector_price)
SELECT collector_price
FROM items_aux
WHERE collector_price IS NOT NULL;


INSERT INTO Loot(quick_sell_price, ID_collector)
SELECT quick_sell_price, Collector.ID_collector
FROM items_aux as ia
JOIN Collector on Collector.collector_price =  ia.collector_price
WHERE quick_sell_price IS NOT NULL;


--Here we should put the Healing_Item INSERT
/*
-- Healing TODO
DELETE FROM Healing_Item;
INSERT INTO Healing_Item(ID_healing_item, healing, revive, healing_revive)
SELECT id, healing, can_revive, healing
FROM items_aux as ia
WHERE healing IS NOT NULL;*/


INSERT INTO Pokeball(ID_pokeball, top_capture_rate, min_capture_rate)
SELECT  id, top_capture_rate, min_capture_rate
FROM items_aux
WHERE top_capture_rate IS NOT NULL AND min_capture_rate IS NOT NULL;


INSERT INTO Boosting(ID_boosting, stat_increase_time, statistic)
SELECT  id, stat_increase_time, statistic
FROM items_aux
WHERE stat_increase_time IS NOT NULL AND statistic IS NOT NULL;


INSERT INTO Movement(ID_movement, name, precision, power_points, power, damage_class, priority_place, objective_type
                      special_effect, probability_effect, ID_type, min_hits, max_hits, stat_change_rate, change_amount, ID_stat)
SELECT m.move_id, m.name, m.accuracy, m.pp, m.power, m.move_damage_class, m.priority, m.target,
       m.effect, m.flinch_chance, t.ID_type, m.min_hits, m.max_hits, m.stat_change_rate, m.change_amount, s.ID_stat
FROM moves_aux AS m
JOIN Types AS t ON t.name = m.type
JOIN Stat AS s ON s.stat_name = m.stat;


INSERT INTO Technical_Machine(ID_movement)
SELECT mov.ID_movement
FROM items_aux as ia
JOIN Movement as mov on ia.move = mov.name;


ALTER TABLE Store DROP CONSTRAINT store_id_city_fkey CASCADE;
INSERT INTO Store(ID_store, name, floors, ID_city)
SELECT sa.storeID, sa.store_name, sa.floors, Area.ID_area
FROM stores_aux as sa
JOIN Area on Area.name = sa.city;


ALTER TABLE Store_Object DROP CONSTRAINT store_object_id_store_fkey CASCADE;
INSERT INTO Store_Object(ID_store, ID_object, stock, discount)
SELECT  sia.storeID, sia.itemID, sia.stock, sia.discount
FROM store_items_aux as sia;


--Here we should put the Sale INSERT


ALTER TABLE Purchase DROP CONSTRAINT purchase_id_trainer_fkey CASCADE;
ALTER TABLE Purchase DROP CONSTRAINT purchase_id_store_fkey CASCADE;
INSERT INTO Purchase(ID_store, ID_trainer, ID_object, amount, cost, discount, date_time)
SELECT  storeID, trainerID, itemID, amount, cost, discount, date_time
FROM purchases_aux;


INSERT INTO Pokemon(ID_pokemon, nickname, level, experience, gender, datetime, obtention_method, position, remaining_health, status_inflicted,
                    ID_pokeball, ID_specie, ID_trainer, ID_nature, ID_item, ID_team, ID_subarea)
SELECT pi.id, pi.nickname, pi.level, pi.experience, pi.gender, pi.datetime, pi.obtention_method, pt.slot, pt.hp, pt.status, 
       p.ID_pokeball, pi.pokemon_speciesID, pi.ownerID, n.ID_nature, o.ID_object, T.ID_team, pi.location_subareaID
FROM pokemon_instances_aux AS pi 
JOIN poketeams_aux AS pt ON pi.id = pt.pokemon
JOIN Team AS t ON t.ID_trainer = pt.trainer
JOIN Nature AS n ON n.name = pi.nature
JOIN Object AS o ON o.name = pi.item
JOIN Object AS p ON p.name = pi.pokeballID;


--Here we should put the Pokemon_Object INSERT
-- Pokemon + Object TODO
/* Em falta la taula Pokemon per poder fer aquesta taula
DELETE FROM Pokemon_Object;
INSERT INTO Pokemon_Object(ID_pokemon, ID_object)
SELECT ID_pokemon, ID_object
FROM Object 
JOIN Pokemon on Pokemon.;*/


INSERT INTO Battle(ID_battle, winner, loser, start_datetime, duration, exp_reward, gold_reward)
SELECT battleID, winnerID, loserID, date_time, duration, experience, gold_reward 
FROM battles_aux;

UPDATE Battle SET ID_gym = ( --We insert a random gym ID for each battle
    SELECT ID_gym
    FROM Gym
    ORDER BY RANDOM()
    LIMIT 1
)
WHERE ID_gym IS NULL; 


INSERT INTO Battle_Result(ID_battle, ID_pokemon, remaining_life, damage_inflicted, damage_received) 
SELECT battleID, pokemon_instanceID, remaining_hp, damage_received, damage_dealt 
FROM battle_statistics_aux;


INSERT INTO Nature(ID_nature, likes_flavour, dislikes_flavour, incremented_stat, decremented_stat, name)
SELECT n.id, bf1.ID_flavour, bf2.ID_flavour, s1.ID_stat, s2.ID_stat, n.name
FROM natures_aux AS n 
JOIN Berry_Flavour AS bf1 ON n.likes_flavor = bf1.name 
JOIN Berry_Flavour AS bf2 ON n.dislikes_flavor = bf2.name
JOIN Stat AS s1 ON n.increased_stat = s1.stat_name
JOIN Stat AS s2 ON n.decreased_stat = s2.stat_name;


INSERT INTO Team(ID_trainer)
SELECT DISTINCT trainer
FROM poketeams_aux;


INSERT INTO Villain(ID_villain, steal_money, iconic_sentence, buddy, ID_org)
SELECT t.id, t.money_stolen, t.phrase, t.partnerID, t.villain_team, c.ID_org
FROM trainers_aux AS t
JOIN Criminal_Org AS c ON c.name = t.villain_team
WHERE t.villain_team IS NOT NULL;


INSERT INTO Criminal_Org(name, building, ID_leader, ID_region, headquarters)
SELECT v.name,v.building, r.ID_region, t.id, a.ID_area
FROM villainous_organizations_aux AS v
JOIN trainers_aux AS t ON v.leader = t.name
JOIN Region AS r ON v.region = r.name
JOIN Area AS a ON v.hq = a.name;


INSERT INTO Trainer_Object(ID_trainer, ID_object, obtention_method, datetime)
SELECT trainerID, itemID, obtention_method, date_time
FROM trainer_items_aux;


INSERT INTO Trainer_Defeats_Gym(ID_trainer, ID_gym)
SELECT DISTINCT t.ID_trainer, g.ID_gym
FROM Trainer AS t 
JOIN Gym AS g ON g.leader != t.name
LIMIT 4;


INSERT INTO Damage(ID_damage, strength)
SELECT move_id, hp_drain
FROM moves_aux
WHERE hp_drain != 0;


INSERT INTO Curation(ID_curation, life_points)
SELECT move_id, hp_healing
FROM moves_aux
WHERE hp_healing != 0;


INSERT INTO State(ID_state, status, status_chance)
SELECT move_id, ailment, ailment_chance
FROM moves_aux
WHERE ailment IS NOT NULL;


INSERT INTO Pokemon_Movement(ID_pokemon, ID_movement)
SELECT id, move1
FROM pokemon_instances_aux
WHERE move1 IS NOT NULL;

INSERT INTO Pokemon_Movement(ID_pokemon, ID_movement)
SELECT id, move2
FROM pokemon_instances_aux
WHERE move2 IS NOT NULL;

INSERT INTO Pokemon_Movement(ID_pokemon, ID_movement)
SELECT id, move3
FROM pokemon_instances_aux
WHERE move3 IS NOT NULL;

INSERT INTO Pokemon_Movement(ID_pokemon, ID_movement)
SELECT id, move4
FROM pokemon_instances_aux
WHERE move4 IS NOT NULL;


INSERT INTO pokemon_stat (ID_pokemon, ID_stat, base_stat, effort)
SELECT p.index, s.id_stat, sa.base_stat, sa.effort
FROM pokemon_aux p
JOIN stats_aux sa ON p.pokemon = sa.pokemon
JOIN stat s ON s.stat_name = sa.stat;


INSERT INTO pokemon_types (ID_pokemon, ID_type, is_primary)
SELECT p.index, t.id_type, true
FROM pokemon_aux p, types t
WHERE p.type1 = t.name;

INSERT INTO pokemon_types (ID_pokemon, ID_type, is_primary)
SELECT p.index, t.id_type, false
FROM pokemon_aux p, types t
WHERE p.type2 = t.name;


INSERT INTO evolve (ID_base, ID_evolution,time, gender, location, min_happiness, min_level, item, is_baby, trigger, know_move)
SELECT s1.id_specie, s2.id_specie,time_of_day, gender, location,min_happiness , min_level, item, is_baby, trigger, known_move 
FROM evolutions_aux e
JOIN specie s1 ON e.baseid = s1.name
JOIN specie s2 ON e.evolutionid = s2.name;
