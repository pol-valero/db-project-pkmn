--Ability 

DROP TABLE IF EXISTS Ability CASCADE;
CREATE TABLE Ability (
    ID_ability SERIAL PRIMARY KEY,
    name VARCHAR(10000),
    effect VARCHAR(10000),
    short_effect TEXT 
);

--Types

DROP TABLE IF EXISTS Types CASCADE;
CREATE TABLE Types (
    ID_type SERIAL PRIMARY KEY, 
    name VARCHAR(255) 
);

-- Relation
DROP TABLE IF EXISTS Relation CASCADE;
CREATE TABLE Relation (
ID_type1 INTEGER,
ID_type2 INTEGER,
multiplier VARCHAR(255),
PRIMARY KEY (ID_type1, ID_type2),
FOREIGN KEY (ID_type1) REFERENCES Types (ID_type),
FOREIGN KEY (ID_type2) REFERENCES Types (ID_type)
);

-- Growth_rates

DROP TABLE IF EXISTS Growth_rates CASCADE;
CREATE TABLE Growth_rates (
    ID_growth_rate SERIAL PRIMARY KEY,
    name VARCHAR (255),
    formula TEXT
);

DROP TABLE IF EXISTS Level CASCADE;
CREATE TABLE Level (
    id_level INTEGER, 
    PRIMARY KEY (id_level)
);

DROP TABLE IF EXISTS growth_level CASCADE; 
CREATE TABLE growth_level (
    id_level INTEGER, 
    id_growth_rate INTEGER, 
    PRIMARY KEY (id_level, id_growth_rate), 
    FOREIGN KEY (id_level) REFERENCES Level (id_level),
    FOREIGN KEY (id_growth_rate) REFERENCES Growth_rates (id_growth_rate),
    experience BIGINT
);
-- Stat

DROP TABLE IF EXISTS Stat CASCADE; 
CREATE TABLE Stat (
    ID_stat SERIAL PRIMARY KEY,
    stat_name  VARCHAR(255) 
);

-- Region
DROP TABLE IF EXISTS Region CASCADE;
CREATE TABLE Region (
    ID_region SERIAL PRIMARY KEY,
    name VARCHAR(255)
);

-- Area
DROP TABLE IF EXISTS Area CASCADE;
CREATE TABLE Area (
    ID_area SERIAL PRIMARY KEY,
    name VARCHAR(255),
    ID_region INTEGER,
    FOREIGN KEY (ID_region) REFERENCES Region (ID_region)
);

-- Pavement
DROP TABLE IF EXISTS Pavement CASCADE;
CREATE TABLE Pavement (
    ID_pavement SERIAL PRIMARY KEY,
    type VARCHAR(255)
);

-- Route
DROP TABLE IF EXISTS Route CASCADE;
CREATE TABLE Route (
    ID_route SERIAL PRIMARY KEY,
    km_length INTEGER,
    ID_pavement INTEGER,
    FOREIGN KEY (ID_route) REFERENCES Area (ID_area),
    FOREIGN KEY (ID_pavement) REFERENCES Pavement (ID_pavement)
);

-- Cardinal Point
DROP TABLE IF EXISTS Cardinal_Point CASCADE;
CREATE TABLE Cardinal_Point (
    ID_cardinal_point SERIAL PRIMARY KEY,
    name VARCHAR(255)
);

-- Route + Area
DROP TABLE IF EXISTS Route_Area CASCADE;
CREATE TABLE Route_Area (
    ID_area INTEGER,
    ID_route INTEGER,
    ID_cardinal_point_route INTEGER,
    PRIMARY KEY (ID_area, ID_route, ID_cardinal_point_route),
    FOREIGN KEY (ID_area) REFERENCES Area (ID_area),
    FOREIGN KEY (ID_route) REFERENCES Route (ID_route),
    FOREIGN KEY (ID_cardinal_point_route) REFERENCES Cardinal_Point (ID_cardinal_point)
);


-- Badge
DROP TABLE IF EXISTS Badge CASCADE;
CREATE TABLE Badge (
    ID_badge SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

-- Object
DROP TABLE IF EXISTS Object CASCADE;
CREATE TABLE Object (
    ID_object SERIAL PRIMARY KEY,
    name VARCHAR(255),
    cost INTEGER,
    effect TEXT,
    available BOOLEAN,
    on_sale BOOLEAN
);

-- Trainer
DROP TABLE IF EXISTS Trainer CASCADE;
CREATE TABLE Trainer (
    ID_trainer SERIAL,
    name VARCHAR(255),
    exp_points INTEGER,
    gold INTEGER, 
    class VARCHAR(255),
    gift_item INTEGER,
    PRIMARY KEY (ID_trainer),
    FOREIGN KEY (gift_item) REFERENCES Object (ID_object)
);

-- Leader
DROP TABLE IF EXISTS Gym_Leader CASCADE;
CREATE TABLE Gym_Leader (
    ID_gym_leader INTEGER,
    PRIMARY KEY (ID_gym_leader),
    FOREIGN KEY (ID_gym_leader) REFERENCES Trainer (ID_trainer)
);

-- Specie

DROP TABLE IF EXISTS Specie CASCADE; 
CREATE TABLE Specie (
    ID_specie SERIAL PRIMARY KEY,
    name VARCHAR(255), 
    base_experience INT, 
    height INTEGER, 
    weight INTEGER,
    dex_order INT,
    growth_rate_id INTEGER, 
    FOREIGN KEY (growth_rate_id) REFERENCES Growth_rates (ID_growth_rate)
);

-- Specie_ability

DROP TABLE IF EXISTS Specie_Ability CASCADE;
CREATE TABLE Specie_Ability (
    ID_specie INTEGER,
    ID_ability INTEGER, 
    PRIMARY KEY (ID_ability, ID_specie),
    FOREIGN KEY (ID_ability) REFERENCES Ability (ID_ability),
    FOREIGN KEY (ID_specie) REFERENCES Specie (ID_specie),
    slot INTEGER,
    is_hidden BOOLEAN
);

-- Gym
DROP TABLE IF EXISTS Gym CASCADE;
CREATE TABLE Gym (
    ID_gym SERIAL PRIMARY KEY,
    name VARCHAR(255),
    ID_badge INTEGER,
    ID_object INTEGER,
    ID_leader INTEGER,
    ID_type INTEGER,
    FOREIGN KEY (ID_badge) REFERENCES Badge (ID_badge),
    FOREIGN KEY (ID_object) REFERENCES Object (ID_object),
    FOREIGN KEY (ID_leader) REFERENCES Gym_Leader (ID_gym_leader),
    FOREIGN KEY (ID_type) REFERENCES Types (ID_type)
);

-- City
DROP TABLE IF EXISTS City CASCADE;
CREATE TABLE City (
    ID_city SERIAL PRIMARY KEY,
    ID_gym INTEGER,
    population INTEGER,
    FOREIGN KEY (ID_city) REFERENCES Area (ID_area),
    FOREIGN KEY (ID_gym) REFERENCES Gym (ID_gym)
);

-- Trainer + Badge

DROP TABLE IF EXISTS Trainer_Badge CASCADE;
CREATE TABLE Trainer_Badge (
    ID_trainer INTEGER,
    ID_badge INTEGER,
    PRIMARY KEY (ID_trainer, ID_badge),
    FOREIGN KEY (ID_trainer) REFERENCES Trainer (ID_trainer),
    FOREIGN KEY (ID_badge) REFERENCES Badge (ID_badge)
);

-- Subarea
DROP TABLE IF EXISTS Subarea CASCADE;
CREATE TABLE Subarea (
    ID_subarea SERIAL PRIMARY KEY,
    name VARCHAR(255),
    ID_area INTEGER,   -- Subarea cannot exist without Area
    FOREIGN KEY (ID_area) REFERENCES Area (ID_area)
);

-- Method
DROP TABLE IF EXISTS Encounter_Method CASCADE;
CREATE TABLE Encounter_Method (
    ID_method SERIAL PRIMARY KEY,
    method_type VARCHAR(255)
);

-- Condition Type
DROP TABLE IF EXISTS Condition_Type CASCADE;
CREATE TABLE Condition_Type (
    ID_condition SERIAL PRIMARY KEY,
    condition_type VARCHAR(255),
    condition_value VARCHAR(255)
);


-- Condition Type + Specie + Subarea + Method
DROP TABLE IF EXISTS Specie_Subarea_Condition_Method CASCADE;
CREATE TABLE Specie_Subarea_Condition_Method (
    ID_method INTEGER,
    ID_subarea INTEGER,
    ID_specie INTEGER,
    chance INTEGER,
	min_level_specie INTEGER,
	max_level_specie INTEGER,
    ID_condition INTEGER,
	PRIMARY KEY (ID_method, ID_subarea, ID_specie, chance, min_level_specie, max_level_specie, ID_condition),
    FOREIGN KEY (ID_method) REFERENCES Encounter_Method (ID_method),
    FOREIGN KEY (ID_subarea) REFERENCES Subarea (ID_subarea),
    FOREIGN KEY (ID_specie) REFERENCES Specie (ID_specie), 
    FOREIGN KEY (ID_condition) REFERENCES Condition_Type (ID_condition)
);

-- Trainer + Gym
DROP TABLE IF EXISTS Trainer_Gym CASCADE;
CREATE TABLE Trainer_Gym (
    ID_trainer SERIAL,
    ID_gym SERIAL,
	PRIMARY KEY (ID_trainer, ID_gym),
    FOREIGN KEY (ID_trainer) REFERENCES Trainer (ID_trainer),
    FOREIGN KEY (ID_gym) REFERENCES Gym (ID_gym)
);

DROP TABLE IF EXISTS Berry CASCADE;
CREATE TABLE Berry (
    ID_berry SERIAL PRIMARY KEY,
    name VARCHAR(255),
    growth_time INTEGER,
    max_num_harvest INTEGER,
    natural_gift_powder INTEGER,
    berry_avg_size INTEGER,
    smoothness INTEGER,
    soil_dryness INTEGER,
    firmness VARCHAR(255),
    FOREIGN KEY (ID_berry)
        REFERENCES Object (ID_object)
);

DROP TABLE IF EXISTS Berry_Flavour CASCADE;
CREATE TABLE Berry_Flavour (
    ID_flavour SERIAL PRIMARY KEY,
    name VARCHAR(255)
);

DROP TABLE IF EXISTS Berry_BerryFlavour CASCADE;
CREATE TABLE Berry_BerryFlavour (
    ID_berry INTEGER NOT NULL,
    ID_flavour INTEGER NOT NULL,
	potency INTEGER NOT NULL,
    PRIMARY KEY (ID_berry, ID_flavour),
    FOREIGN KEY (ID_berry)
        REFERENCES Object (ID_object),
    FOREIGN KEY (ID_flavour)
        REFERENCES Object (ID_object)
);

DROP TABLE IF EXISTS Collector CASCADE;
CREATE TABLE Collector (
    ID_collector SERIAL PRIMARY KEY,
    collector_price INTEGER
);

DROP TABLE IF EXISTS Loot CASCADE;
CREATE TABLE Loot (
    ID_loot SERIAL PRIMARY KEY,
    quick_sell_price INTEGER,
    ID_collector INTEGER,
    FOREIGN KEY (ID_loot)
        REFERENCES Object (ID_object),
    FOREIGN KEY (ID_collector)
        REFERENCES Collector (ID_collector)
);

DROP TABLE IF EXISTS Healing_Item CASCADE;
CREATE TABLE Healing_Item (
    ID_healing_item SERIAL PRIMARY KEY,
    description TEXT,
    healing INTEGER,
    revive BOOLEAN,
    healing_revive INTEGER,
    FOREIGN KEY (ID_healing_item)
        REFERENCES Object (ID_object)
);

DROP TABLE IF EXISTS Pokeball CASCADE;
CREATE TABLE Pokeball (
    ID_pokeball SERIAL PRIMARY KEY,
    top_capture_rate INTEGER,
    min_capture_rate INTEGER,
    condition TEXT,
    FOREIGN KEY (ID_pokeball)
        REFERENCES Object (ID_object)
);

DROP TABLE IF EXISTS Boosting CASCADE;
CREATE TABLE Boosting (
    ID_boosting SERIAL PRIMARY KEY,
    stat_increase_time INTEGER,
    statistic VARCHAR(255),
    FOREIGN KEY (ID_boosting)
        REFERENCES Object (ID_object)
);

DROP TABLE IF EXISTS Movement CASCADE;
CREATE TABLE Movement (
    ID_movement SERIAL,
    name VARCHAR(255),
    precision INT, 
    power_points INT,
    power INT, 
    damage_class VARCHAR(255),
    priority_place INT,
    objective_type VARCHAR(255),
    special_effect VARCHAR(255),
    probability_effect INT,
    ID_type INT,
    min_hits INT,
    max_hits INT,
    stat_change_rate INT,
    change_amount INT, 
    ID_stat INT,
    PRIMARY KEY (ID_movement),
    FOREIGN KEY (ID_type) REFERENCES Types (ID_type),
    FOREIGN KEY (ID_stat) REFERENCES Stat (ID_stat)
);

DROP TABLE IF EXISTS Technical_Machine CASCADE;
CREATE TABLE Technical_Machine (
    ID_machine SERIAL PRIMARY KEY,
    ID_movement INTEGER,
    FOREIGN KEY (ID_machine)
        REFERENCES Object (ID_object),
    FOREIGN KEY (ID_movement)
        REFERENCES Movement (ID_movement)
);


DROP TABLE IF EXISTS Store CASCADE;
CREATE TABLE Store (
    ID_store SERIAL PRIMARY KEY,
    name VARCHAR(255),
    floors INTEGER,
    ID_city INTEGER,
    FOREIGN KEY(ID_city)
        REFERENCES City (ID_city)
);

DROP TABLE IF EXISTS Store_Object CASCADE;
CREATE TABLE Store_Object (
    ID_store INTEGER NOT NULL,
    ID_object INTEGER NOT NULL,
    discount INTEGER,
    stock INTEGER,  
    PRIMARY KEY (ID_store, ID_object),
    FOREIGN KEY(ID_store)
        REFERENCES Store (ID_store),
    FOREIGN KEY(ID_object)
        REFERENCES Object (ID_object)
);

DROP TABLE IF EXISTS Sale CASCADE;
CREATE TABLE Sale (
    ID_sale SERIAL PRIMARY KEY,
    cost INTEGER,
    ID_trainer INTEGER,
    ID_object INTEGER,
    ID_store INTEGER,
    FOREIGN KEY (ID_trainer)
        REFERENCES Trainer (ID_trainer),
    FOREIGN KEY (ID_object)
        REFERENCES Object (ID_object),
    FOREIGN KEY (ID_store)
        REFERENCES Store (ID_store)
);

DROP TABLE IF EXISTS Purchase CASCADE;
CREATE TABLE Purchase (
    ID_purchase SERIAL PRIMARY KEY,
    cost INTEGER,
    ID_trainer INTEGER,
    ID_object INTEGER,
    ID_store INTEGER,
    discount INTEGER,
    date_time DATE, 
    amount INTEGER,
    FOREIGN KEY (ID_trainer)
        REFERENCES Trainer (ID_trainer),
    FOREIGN KEY (ID_object)
        REFERENCES Object (ID_object),
    FOREIGN KEY (ID_store)
        REFERENCES Store (ID_store)
);

DROP TABLE IF EXISTS Nature CASCADE;
CREATE TABLE Nature (
    ID_nature SERIAL,
    likes_flavour INTEGER,
    dislikes_flavour INTEGER,
    incremented_stat INTEGER,
    decremented_stat INTEGER,
    name VARCHAR(255),
    PRIMARY KEY (ID_nature),
    FOREIGN KEY (likes_flavour) REFERENCES Berry_Flavour (ID_flavour),
    FOREIGN KEY (dislikes_flavour) REFERENCES Berry_Flavour (ID_flavour),
    FOREIGN KEY (incremented_stat) REFERENCES Stat (ID_stat),
    FOREIGN KEY (decremented_stat) REFERENCES Stat (ID_stat)
);

DROP TABLE IF EXISTS Team CASCADE;
CREATE TABLE Team (
    ID_team SERIAL,
    ID_trainer INTEGER,
    PRIMARY KEY (ID_team),
    FOREIGN KEY (ID_trainer) REFERENCES Trainer (ID_trainer)
);

DROP TABLE IF EXISTS Pokemon CASCADE;
CREATE TABLE Pokemon (
    ID_pokemon SERIAL, 
    nickname VARCHAR (255), 
    level INT, 
    experience INT,
    gender VARCHAR (255),
    datetime TIMESTAMP,
    obtention_method VARCHAR (255),
    position INTEGER, 
    remaining_health INTEGER, 
    status_inflicted VARCHAR(255), 
    ID_pokeball INTEGER,
    ID_specie INTEGER,
    ID_trainer INTEGER,
    ID_nature INTEGER,
    ID_item INTEGER,
    ID_team INTEGER,
    ID_subarea INTEGER, 

    PRIMARY KEY (ID_pokemon),
    FOREIGN KEY (ID_pokeball) REFERENCES Pokeball (ID_pokeball),
    FOREIGN KEY (ID_specie) REFERENCES Specie (ID_specie),
    FOREIGN KEY (ID_trainer) REFERENCES Trainer (ID_trainer),
    FOREIGN KEY (ID_nature) REFERENCES Nature (ID_nature),
    FOREIGN KEY (ID_item) REFERENCES Object (ID_object),
    FOREIGN KEY (ID_team) REFERENCES Team (ID_team),
    FOREIGN KEY (ID_subarea) REFERENCES Subarea (ID_subarea)
);

DROP TABLE IF EXISTS Pokemon_Object CASCADE;
CREATE TABLE Pokemon_Object(
    ID_pokemon INTEGER NOT NULL,
    ID_object INTEGER NOT NULL,
    PRIMARY KEY (ID_pokemon, ID_object),
    FOREIGN KEY(ID_pokemon)
        REFERENCES Pokemon (ID_pokemon),
    FOREIGN KEY(ID_object)
        REFERENCES Object (ID_object)
);

DROP TABLE IF EXISTS Battle CASCADE;
CREATE TABLE Battle (
    ID_battle SERIAL,
    winner INTEGER,
    loser INTEGER,
    ID_gym INTEGER,
    start_datetime TIMESTAMP,
    duration INTEGER,
    exp_reward INTEGER,
    gold_reward INTEGER,
    PRIMARY KEY (ID_battle),
    FOREIGN KEY (winner) REFERENCES Trainer (ID_trainer),
    FOREIGN KEY (loser) REFERENCES Trainer (ID_trainer),
    FOREIGN KEY (ID_gym) REFERENCES Gym (ID_gym)
);

DROP TABLE IF EXISTS Battle_Result CASCADE;
CREATE TABLE Battle_Result (
    ID_battle INTEGER,
    ID_pokemon INTEGER,
    remaining_life INTEGER,
    damage_inflicted INTEGER,  
    damage_received INTEGER,  
    PRIMARY KEY (ID_battle, ID_pokemon),
    FOREIGN KEY (ID_battle) REFERENCES Battle (ID_battle),
    FOREIGN KEY (ID_pokemon) REFERENCES Pokemon (ID_pokemon)
);


DROP TABLE IF EXISTS Villain CASCADE;
CREATE TABLE Villain (
    ID_villain INT,
    steal_money INT,
    iconic_sentence VARCHAR(255),
    buddy INT,
    ID_org INT,
    PRIMARY KEY (ID_villain),
    FOREIGN KEY (buddy) REFERENCES Villain (ID_villain),
    FOREIGN KEY (ID_villain) REFERENCES Trainer (ID_trainer)
);

DROP TABLE IF EXISTS Criminal_Org CASCADE;
CREATE TABLE Criminal_Org (
    ID_org SERIAL,
    name VARCHAR(255),
    building VARCHAR(255),
    ID_leader INTEGER,
    ID_region INTEGER,
    headquarters INTEGER,
    PRIMARY KEY (ID_org),
    FOREIGN KEY (ID_leader) REFERENCES Trainer (ID_trainer),
    FOREIGN KEY (ID_region) REFERENCES Region (ID_region),
    FOREIGN KEY (headquarters) REFERENCES Area (ID_area)
);

ALTER TABLE Villain ADD FOREIGN KEY (ID_org) REFERENCES Criminal_Org (ID_org);

DROP TABLE IF EXISTS Trainer_Object CASCADE;
CREATE TABLE Trainer_Object (
    ID_trainer INTEGER,
    ID_object INTEGER,
    obtention_method VARCHAR(255),
    datetime TIMESTAMP,  
    PRIMARY KEY (ID_trainer, ID_object),
    FOREIGN KEY (ID_trainer) REFERENCES Trainer (ID_trainer),
    FOREIGN KEY (ID_object) REFERENCES Object (ID_object)
);

DROP TABLE IF EXISTS Trainer_Defeats_Gym CASCADE;
CREATE TABLE Trainer_Defeats_Gym (
    ID_trainer INTEGER,
    ID_gym INTEGER,
    PRIMARY KEY (ID_trainer, ID_gym),
    FOREIGN KEY (ID_trainer) REFERENCES Trainer (ID_trainer),
    FOREIGN KEY (ID_gym) REFERENCES Gym (ID_gym)
);

DROP TABLE IF EXISTS Damage CASCADE;
CREATE TABLE Damage (
    ID_damage INT,
    strength INT, 
    PRIMARY KEY (ID_damage),
    FOREIGN KEY (ID_damage) REFERENCES Movement (ID_movement)
);

DROP TABLE IF EXISTS Curation CASCADE;
CREATE TABLE Curation (
    ID_curation INT,
    life_points INT, 
    PRIMARY KEY (ID_curation),
    FOREIGN KEY (ID_curation) REFERENCES Movement (ID_movement)
);

DROP TABLE IF EXISTS State CASCADE;
CREATE TABLE State (
    ID_state INT,
    status VARCHAR(255),
    status_chance INT,
    PRIMARY KEY (ID_state),
    FOREIGN KEY (ID_state) REFERENCES Movement (ID_movement)
);

DROP TABLE IF EXISTS Pokemon_Movement CASCADE; 
CREATE TABLE Pokemon_Movement (
    ID_pokemon INTEGER,
    ID_movement INTEGER,
    PRIMARY KEY (ID_pokemon, ID_movement),
    FOREIGN KEY (ID_pokemon) REFERENCES Pokemon (ID_pokemon),
    FOREIGN KEY (ID_movement) REFERENCES Movement (ID_movement)
);

 DROP TABLE IF EXISTS Pokemon_Stat CASCADE;
 CREATE TABLE Pokemon_Stat(
    ID_specie INTEGER,
    ID_stat INTEGER, 
    PRIMARY KEY (ID_specie, ID_stat),
    FOREIGN KEY (ID_specie) REFERENCES Specie (ID_specie),
    FOREIGN KEY (ID_stat) REFERENCES Stat (ID_stat),
    base_stat INTEGER,
    effort INTEGER 
 );


DROP TABLE IF EXISTS Pokemon_Types CASCADE;
CREATE TABLE Pokemon_Types (
    ID_specie INTEGER, 
    ID_type INTEGER,
	is_primary BOOLEAN,
    PRIMARY KEY (ID_specie, ID_type),
    FOREIGN KEY (ID_specie) REFERENCES Specie (ID_specie),
    FOREIGN KEY (ID_type) REFERENCES Types (ID_type)
);

DROP TABLE IF EXISTS Evolve CASCADE;
CREATE TABLE Evolve (
	ID_evolution SERIAL,
    ID_current_specie INTEGER,
    ID_next_specie INTEGER,
    time VARCHAR (255), 
    gender VARCHAR(255),
    location INTEGER,
    min_happiness VARCHAR (255),
    min_level INTEGER,
    item VARCHAR(255),
    is_baby BOOLEAN,
    trigger VARCHAR(255),
    known_move VARCHAR(255),
    ID_object INTEGER,
    ID_area INTEGER,
	PRIMARY KEY (ID_evolution, ID_current_specie, ID_next_specie),
	FOREIGN KEY (ID_current_specie) REFERENCES Specie (ID_specie),
	FOREIGN KEY (ID_next_specie) REFERENCES Specie (ID_specie),
    FOREIGN KEY (ID_object) REFERENCES Object (ID_object),
    FOREIGN KEY (ID_area) REFERENCES Area (ID_area)
);
