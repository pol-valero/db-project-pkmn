---- 4. EXPLORACIÓ

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
