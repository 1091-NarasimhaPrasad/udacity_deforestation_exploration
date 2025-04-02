-- (a) Total forest area of the world in 1990
SELECT country_name, forest_area_sqkm
FROM forest_area
WHERE country_name = 'World' AND year = 1990;

-- (b) Total forest area of the world in 2016
SELECT country_name, forest_area_sqkm
FROM forest_area
WHERE country_name = 'World' AND year = 2016;

-- (c) & (d) Change in forest area and percent change
WITH t1 AS (
    SELECT forest_area_sqkm AS area_1990
    FROM forest_area
    WHERE country_name = 'World' AND year = 1990
), 
t2 AS (
    SELECT forest_area_sqkm AS area_2016
    FROM forest_area
    WHERE country_name = 'World' AND year = 2016
)
SELECT 
    t2.area_2016, 
    t1.area_1990, 
    t2.area_2016 - t1.area_1990 AS area_change, 
    ROUND((t2.area_2016 - t1.area_1990) / t1.area_1990 * 100, 2) AS area_percent_change 
FROM t1 
CROSS JOIN t2;

-- (e) Country with total area closest to forest loss
SELECT 
    country_name, 
    year, 
    ROUND((total_area_sq_mi * 2.58999), 0) AS total_area_sqkm
FROM land_area
WHERE year = 2016
AND (total_area_sq_mi * 2.58999) < (
    (SELECT forest_area_sqkm FROM forest_area WHERE country_name = 'World' AND year = 1990) -
    (SELECT forest_area_sqkm FROM forest_area WHERE country_name = 'World' AND year = 2016)
)
ORDER BY total_area_sqkm DESC 
LIMIT 1;
