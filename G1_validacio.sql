-- Region: check if there are the same regions in auxiliar csv than in the imported one.
SELECT name, 'Taula regió - importada' AS note
FROM Region
UNION ALL
SELECT region, 'Taula aux_locations - locations.csv' AS note
FROM aux_locations
GROUP BY region
ORDER BY note, name;
