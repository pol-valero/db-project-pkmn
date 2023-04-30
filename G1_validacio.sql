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

-- validación de habilidades con especie 

SELECT DISTINCT a.name, a.effect
FROM Ability AS a
JOIN specie_ability as sa ON a.id_ability = sa.id_ability
JOIN specie AS s ON sa.id_specie = s.id_specie
WHERE sa.is_hidden = 'false' AND s.id_specie < 10

-- validacion de evoluciones (eejcutar por separado los 3)

SELECT s.name
FROM specie As s 
JOIN evolve AS e ON s.id_specie = id_current_specie
WHERE is_baby = 'true';

SELECT s.baseid AS names_baby
FROM evolutions_aux AS s
WHERE s.is_baby = 'true'

SELECT s.name AS no_coinciden 
FROM specie As s 
JOIN evolve AS e ON s.id_specie = id_current_specie
WHERE is_baby = 'true'
EXCEPT
SELECT s.baseid AS names_baby
FROM evolutions_aux AS s
WHERE s.is_baby = 'true';

-- validación de las stats(ejecutar los dos SELECT por separado)

SELECT stat.stat_name, specie_stat.base_stat
FROM specie_stat
JOIN stat ON specie_stat.id_stat = stat.id_stat
WHERE specie_stat.id_specie = 1 

SELECT stat.stat_name, specie_stat.base_stat
FROM specie_stat
JOIN stat ON specie_stat.id_stat = stat.id_stat
JOIN specie ON specie_stat.id_specie = specie.id_specie
WHERE specie.name = 'charmander'

-- validación de la experiencia y los ratios 

  SELECT p.id_pokemon, p.level,  p.experience as pokemon_experience, g.formula as growth_formula, gl_next.experience as required_experience
FROM pokemon as p
  JOIN specie s ON p.id_specie = s.id_specie
  JOIN growth_rates g ON s.growth_rate_id = g.id_growth_rate
  JOIN growth_level gl ON s.growth_rate_id = gl.id_growth_rate AND p.level = gl.id_level
  LEFT JOIN growth_level gl_next ON s.growth_rate_id = gl_next.id_growth_rate AND p.level + 1 = gl_next.id_level
WHERE 
  p.id_pokemon IN (SELECT id_pokemon FROM pokemon LIMIT 5);


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

-- Encounters: Select the encounters with walk method and a time condition, with a minimum level of 5 and a chance higher than 20.
SELECT pokemon AS encounters_locations_csv
FROM aux_encounters
WHERE method = 'walk' AND condition_type = 'time' AND min_level = 5 AND chance > 20
GROUP BY pokemon;


SELECT s.name AS encounters_imported FROM Specie_Subarea_Condition_Method AS enc
JOIN Specie AS s ON s.ID_specie = enc.id_specie
JOIN Subarea AS sub ON sub.ID_subarea = enc.id_subarea
JOIN Encounter_Method AS em ON em.ID_method = enc.id_method
JOIN Condition AS c ON c.id_condition = enc.id_condition
WHERE em.method_type = 'walk' AND c.condition_type = 'time' AND enc.min_level_specie = 5 AND enc.chance_percentage > 20
GROUP BY s.name;

-- Routes: Select only routes with an area north that start with o or O. 
SELECT a.name AS areaName_routes_imported, route.name AS routeName_routes_imported FROM Route_Area AS ra
JOIN Area AS a ON a.ID_area = ra.ID_area
JOIN Area AS route ON route.ID_area = ra.ID_route
JOIN Cardinal_Point AS cp ON cp.ID_cardinal_point = ra.id_cardinal_point_route
WHERE cp.name = 'North' AND LOWER(a.name) LIKE 'o%'
GROUP BY route.name, a.name;

SELECT north AS northArea_routes_csv, route AS routeName_routes_csv FROM aux_routes
WHERE LOWER(north) LIKE 'o%';
