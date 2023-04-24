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
FROM '/Users/Shared/BBDD/purchases.csv'
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
FROM '/Users/Shared/BBDD/stores.csv'
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
FROM '/Users/Shared/BBDD/storeitems.csv'
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
FROM '/Users/Shared/BBDD/items.csv'
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
FROM '/Users/Shared/BBDD/berries.csv'
DELIMITER ','
CSV HEADER;

DROP TABLE IF EXISTS berries_flavours_aux;
CREATE TABLE IF NOT EXISTS berries_flavours_aux (
    berry VARCHAR(255),
    flavour VARCHAR(255),
    potency INTEGER
);

COPY berries_flavours_aux(berry, flavour, potency)
FROM '/Users/Shared/BBDD/berries_flavours.csv'
DELIMITER ','
CSV HEADER;
