-------------------- VALIDACIÓ DE DADES: POKEMONS --------------------
-- tipos 

SELECT COUNT (DISTINCT t.id_type) FROM types t;
SELECT COUNT (DISTINCT t.id) FROM type_aux t;

-- multiplicador de daño
SELECT DISTINCT r.multiplier AS multiplier, r.id_type1, r.id_type2
FROM relation AS r 
JOIN movement AS m ON r.id_type1 = m.id_type 
JOIN specie AS s ON r.id_type2 =  s.id_specie
WHERE m.name = 'swords dance'
LIMIT 3; 


-------------------- VALIDACIÓ DE DADES: COMPRES --------------------

-- LOOT
SELECT id, name, quick_sell_price, collector_price FROM items_aux
WHERE collector_price IS NOT NULL
ORDER BY id;

SELECT * FROM Loot 
JOIN Collector as c on c.id_collector = Loot.id_collector
ORDER BY ID_loot;


-- BOOSTING
SELECT  id, stat_increase_time, statistic FROM items_aux
WHERE stat_increase_time IS NOT NULL AND statistic IS NOT NULL;

SELECT * FROM Boosting;

-- HEALING ITEM
SELECT id, healing, can_revive FROM items_aux
WHERE healing != ''
ORDER BY id;

SELECT id_healing_item, healing, revive, healing_revive FROM Healing_Item ORDER BY id_healing_item;


-- TECHNICAL MACHINE
SELECT mov.ID_movement
FROM items_aux as ia
JOIN Movement as mov on ia.move = mov.name
LIMIT 10;

SELECT * FROM technical_machine LIMIT 10;

-- POKEBALL
SELECT  id, top_capture_rate, min_capture_rate
FROM items_aux
WHERE top_capture_rate IS NOT NULL AND min_capture_rate IS NOT NULL;

SELECT * FROM Pokeball;

-- BERRY I BERRY FLAVOUR

-- COLLECTOR

-- STORE


-------------------- VALIDACIÓ DE DADES: EXPLORACIÓ --------------------

-- Region: check if there are the same regions in auxiliar csv than in the imported one.
SELECT name, 'Taula regió - importada' AS note
FROM Region
UNION ALL
SELECT region, 'Taula aux_locations - locations.csv' AS note
FROM aux_locations
GROUP BY region
ORDER BY note, name;

-- Area: check if there are the same regions in auxiliar csv than in the imported one.
SELECT region AS region_locations_csv, area AS area_locations_csv FROM aux_locations
GROUP BY region, area
ORDER BY region, area;

SELECT r.name AS region_imported, a.name AS area_imported FROM Area AS a
JOIN Region AS r ON r.ID_region = a.ID_region
ORDER BY r.name, a.name;

-- Repeated areas: check areas with the same name that are in different regions.
SELECT a1.region AS region_locations_csv, a1.area AS area_locations_csv
FROM aux_locations a1
JOIN aux_locations a2 ON a1.area = a2.area AND a1.region <> a2.region
GROUP BY a1.region, a1.area
ORDER BY a1.area, a1.region;

SELECT r.name AS region_imported, a1.name AS area_imported
FROM Area AS a1
JOIN Region AS r ON r.ID_region = a1.ID_region
JOIN Area AS a2 ON a2.name = a1.name AND a2.ID_region <> a1.ID_region
JOIN Region AS r2 ON r2.ID_region = a2.ID_region
GROUP BY r.name, a1.name
ORDER BY a1.name, r.name;
