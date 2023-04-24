-- Region
DROP TABLE IF EXISTS Region CASCADE;
CREATE TABLE IF NOT EXISTS Region (
    ID_region SERIAL PRIMARY KEY,
    name VARCHAR(255)
);

-- Area
DROP TABLE IF EXISTS Area CASCADE;
CREATE TABLE IF NOT EXISTS Area (
    ID_area SERIAL PRIMARY KEY,
    name VARCHAR(255),
    ID_region INTEGER,
    FOREIGN KEY (ID_region) REFERENCES Region (ID_region)
);

-- Pavement
DROP TABLE IF EXISTS Pavement CASCADE;
CREATE TABLE IF NOT EXISTS Pavement (
    ID_pavement SERIAL PRIMARY KEY,
    type VARCHAR(255)
);

-- Route
DROP TABLE IF EXISTS Route CASCADE;
CREATE TABLE IF NOT EXISTS Route (
    ID_route SERIAL PRIMARY KEY,
    km_length INTEGER,
    ID_pavement INTEGER,
    FOREIGN KEY (ID_route) REFERENCES Area (ID_area),
    FOREIGN KEY (ID_pavement) REFERENCES Pavement (ID_pavement)
);


-- Route + Area
DROP TABLE IF EXISTS Route_Area CASCADE;
CREATE TABLE IF NOT EXISTS Route_Area (
    ID_area INTEGER,
    ID_route INTEGER,
    route_cardinal_point VARCHAR(255),
	PRIMARY KEY (ID_area, ID_route),
    FOREIGN KEY (ID_area) REFERENCES Area (ID_area),
    FOREIGN KEY (ID_route) REFERENCES Route (ID_route)
);


-- Badge
DROP TABLE IF EXISTS Badge CASCADE;
CREATE TABLE IF NOT EXISTS Badge (
    ID_badge SERIAL PRIMARY KEY,
    nom VARCHAR(255) NOT NULL
);

-- Object

-- Trainer

-- Leader
DROP TABLE IF EXISTS Leader CASCADE;
CREATE TABLE IF NOT EXISTS Leader (
    ID_leader SERIAL PRIMARY KEY,
    FOREIGN KEY (ID_leader) REFERENCES Trainer (ID_trainer)
);

-- Specie

-- Gym
CREATE TABLE IF NOT EXISTS Gym (
    ID_gym SERIAL PRIMARY KEY,
    name VARCHAR(255),
    ID_badge INTEGER,
    ID_object INTEGER,
    ID_leader INTEGER,
    ID_specie INTEGER,
    FOREIGN KEY (ID_badge) REFERENCES Badge (ID_badge),
    FOREIGN KEY (ID_object) REFERENCES Object (ID_object),
    FOREIGN KEY (ID_leader) REFERENCES Leader (ID_leader),
    FOREIGN KEY (ID_specie) REFERENCES Specie (ID_specie)
);

-- City
DROP TABLE IF EXISTS City CASCADE;
CREATE TABLE IF NOT EXISTS City (
    ID_city SERIAL PRIMARY KEY,
    ID_gym INTEGER,
    population INTEGER,
    FOREIGN KEY (ID_city) REFERENCES Area (ID_area),
    FOREIGN KEY (ID_gym) REFERENCES Gym (ID_gym)
);

-- Trainer + Badge
DROP TABLE IF EXISTS Trainer_Badge CASCADE;
CREATE TABLE IF NOT EXISTS Trainer_Badge (
    ID_trainer INTEGER,
    ID_badge INTEGER,
	PRIMARY KEY (ID_trainer, ID_badge),
    FOREIGN KEY (ID_trainer) REFERENCES Trainer (ID_trainer),
    FOREIGN KEY (ID_badge) REFERENCES Badge (ID_badge)
);

-- Subarea
DROP TABLE IF EXISTS Subarea CASCADE;
CREATE TABLE IF NOT EXISTS Subarea (
    ID_subarea SERIAL PRIMARY KEY,
    name VARCHAR(255),
    ID_area INTEGER,   -- Subarea cannot exist without Area
    FOREIGN KEY (ID_subarea) REFERENCES Area (ID_area),
    FOREIGN KEY (ID_area) REFERENCES Area (ID_area)
);

-- Method
DROP TABLE IF EXISTS Encounter_Method CASCADE;
CREATE TABLE IF NOT EXISTS Encounter_Method (
    ID_method SERIAL PRIMARY KEY,
    method_type VARCHAR(255)
);

-- Condition Type
DROP TABLE IF EXISTS Condition_Type CASCADE;
CREATE TABLE IF NOT EXISTS Condition_Type (
    ID_condition SERIAL PRIMARY KEY,
    condition_type VARCHAR(255),
    condition_value VARCHAR(255)
);

-- Specie

-- Condition Type + Specie + Subarea + Method
DROP TABLE IF EXISTS Specie_Subarea_Condition_Method CASCADE;
CREATE TABLE IF NOT EXISTS Specie_Subarea_Condition_Method (
    ID_method INTEGER,
    ID_subarea INTEGER,
    ID_specie INTEGER,
    chance VARCHAR(255),
    ID_condition INTEGER,
	PRIMARY KEY (ID_method, ID_subarea),
    FOREIGN KEY (ID_method) REFERENCES Encounter_Method (ID_method),
    FOREIGN KEY (ID_subarea) REFERENCES Subarea (ID_subarea),
    FOREIGN KEY (ID_specie) REFERENCES Specie (ID_specie), 
    FOREIGN KEY (ID_condition) REFERENCES Condition_Type (ID_condition)
);

-- Trainer + Gym
DROP TABLE IF EXISTS Trainer_Gym CASCADE;
CREATE TABLE IF NOT EXISTS Trainer_Gym (
    ID_trainer SERIAL,
    ID_gym SERIAL,
	PRIMARY KEY (ID_trainer, ID_gym),
    FOREIGN KEY (ID_trainer) REFERENCES Trainer (ID_trainer),
    FOREIGN KEY (ID_gym) REFERENCES Gym (ID_gym)
);

DROP TABLE IF EXISTS Object CASCADE;
CREATE TABLE Object (
    ID_object SERIAL PRIMARY KEY,
    name VARCHAR(255),
    cost INTEGER,
    effect TEXT,
    available BOOLEAN,
    on_sale BOOLEAN
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
    name VARCHAR(255),
    potency INTEGER
);

DROP TABLE IF EXISTS Berry_BerryFlavour CASCADE;
CREATE TABLE Berry_BerryFlavour (
    ID_berry INTEGER NOT NULL,
    ID_flavour INTEGER NOT NULL,
    PRIMARY KEY (ID_berry, ID_flavour),
    FOREIGN KEY (ID_berry)
        REFERENCES Object (ID_object),
    FOREIGN KEY (ID_flavour)
        REFERENCES Object (ID_object)
);

DROP TABLE IF EXISTS Collector CASCADE;
CREATE TABLE IF NOT EXISTS Collector (
    ID_collector SERIAL PRIMARY KEY,
    preu_boti INTEGER
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
    statistic INTEGER,
    FOREIGN KEY (ID_boosting)
        REFERENCES Object (ID_object)
);

DROP TABLE IF EXISTS Technical_Machine CASCADE;
CREATE TABLE Technical_Machine (
    ID_machine SERIAL PRIMARY KEY,
    ID_move INTEGER,
    FOREIGN KEY (ID_machine)
        REFERENCES Object (ID_object),
    FOREIGN KEY (ID_move)
        REFERENCES Move (ID_move)
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

DROP TABLE IF EXISTS Nature CASCADE;
CREATE TABLE Nature (
    ID_nature SERIAL,
    likes_flavour INTEGER,
    dislikes_flavour INTEGER,
    incremented_stat INTEGER,
    decremented_stat INTEGER,
    name VARCHAR(255),
    PRIMARY KEY (ID_natura),
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

DROP TABLE IF EXISTS Villain CASCADE;
CREATE TABLE Villain (
    ID_villain INT,
    steal_money INT,
    iconic_sentence VARCHAR(255),
    buddy INT,
    ID_org INT,
    PRIMARY KEY (ID_villain),
    FOREIGN KEY (buddy) REFERENCES Villain (ID_villain),
    FOREIGN KEY (ID_org) REFERENCES Criminal_Org (ID_org),
    FOREIGN KEY (ID_villain) REFERENCES Trainer (ID_trainer)
);

DROP TABLE IF EXISTS Gym_Leader CASCADE;
CREATE TABLE Gym_Leader (
    ID_gym_leader INT,
    PRIMARY KEY (ID_gym_leader),
    FOREIGN KEY (ID_gym_leader) REFERENCES Trainer (ID_trainer)
);

DROP TABLE IF EXISTS Criminal_Org CASCADE;
CREATE TABLE Criminal_Org (
    ID_org INTEGER,
    name VARCHAR(255),
    ID_leader INTEGER,
    ID_region INTEGER,
    headquarters INTEGER,
    PRIMARY KEY (ID_org),
    FOREIGN KEY (ID_leader) REFERENCES Villain (ID_Villain),
    FOREIGN KEY (ID_region) REFERENCES Region (ID_region),
    FOREIGN KEY (headquarters) REFERENCES Area (ID_area)
);

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

DROP TABLE IF EXISTS Trainer_Badge CASCADE; 
CREATE TABLE Trainer_Badge (
    ID_trainer INTEGER,
    ID_badge INTEGER,
    PRIMARY KEY (ID_trainer, ID_badge),
    FOREIGN KEY (ID_trainer) REFERENCES Trainer (ID_trainer),
    FOREIGN KEY (ID_badge) REFERENCES Badge (ID_badge)
);

DROP TABLE IF EXISTS Movement CASCADE;
CREATE TABLE Movement (
    ID_movement SERIAL,
    name VARCHAR(255),
    precision INT, 
    power INT, 
    damage_class VARCHAR(255),
    priority_place INT,
    objective_type VARCHAR(255),
    special_effect VARCHAR(255),
    ID_type INT,
    min_hits INT,
    max_hits INT,
    stat_change_rate INT,
    change_amount INT, 
    ID_stat INT,
    PRIMARY KEY (ID_movement),
    FOREIGN KEY (ID_type) REFERENCES Type (ID_type),
    FOREIGN KEY (ID_stat) REFERENCES Stat (ID_stat)
);

DROP TABLE IF EXISTS Damage CASCADE;
CREATE TABLE Damage (
    ID_damage INT,
    força INT, 
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
    status INT,
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
