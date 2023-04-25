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
    healing INTEGER,
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


