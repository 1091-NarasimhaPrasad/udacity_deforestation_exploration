-- (a) Top 5 countries with the largest absolute decrease in forest area (1990-2016)
WITH t1 AS (
    SELECT country_name, year, forest_area_sqkm AS area_1990
    FROM forest_area
    WHERE forest_area_sqkm IS NOT NULL
    AND country_name <> 'World'
    AND year = 1990
),
t2 AS (
    SELECT country_name, year, forest_area_sqkm AS area_2016
    FROM forest_area
    WHERE forest_area_sqkm IS NOT NULL
    AND country_name <> 'World'
    AND year = 2016
)
SELECT t1.country_name, 
       area_1990, 
       area_2016, 
       ROUND(area_2016 - area_1990, 0) AS area_difference, 
       ROUND(((area_2016 - area_1990) / area_1990) * 100, 2) AS area_difference_percent
FROM t1
JOIN t2 ON t1.country_name = t2.country_name
ORDER BY area_difference ASC 
LIMIT 5;

-- (b) Top 5 countries with the largest percent decrease in forest area (1990-2016)
WITH t1 AS (
    SELECT country_name, region, forest_area_sqkm AS area_1990
    FROM forestation
    WHERE forest_area_sqkm IS NOT NULL
    AND country_name <> 'World'
    AND year = 1990
),
t2 AS (
    SELECT country_name, region, forest_area_sqkm AS area_2016
    FROM forestation
    WHERE forest_area_sqkm IS NOT NULL
    AND country_name <> 'World'
    AND year = 2016
)
SELECT t1.country_name, 
       t1.region, 
       area_1990, 
       area_2016, 
       ROUND(area_1990 - area_2016, 0) AS area_difference, 
       ROUND(((area_1990 - area_2016) / area_1990) * 100, 2) AS area_percent
FROM t1
JOIN t2 ON t1.country_name = t2.country_name
ORDER BY area_percent DESC 
LIMIT 5;

-- (c) Count of countries in each forestation quartile (2016)
WITH t1 AS (
    SELECT country_name, forest_as_percent_of_land
    FROM forestation
    WHERE year = 2016
    AND country_name <> 'World'
)
SELECT 
    COUNT(CASE WHEN forest_as_percent_of_land <= 25 THEN 1 END) AS quartile_1,
    COUNT(CASE WHEN forest_as_percent_of_land > 25 AND forest_as_percent_of_land <= 50 THEN 1 END) AS quartile_2,
    COUNT(CASE WHEN forest_as_percent_of_land > 50 AND forest_as_percent_of_land <= 75 THEN 1 END) AS quartile_3,
    COUNT(CASE WHEN forest_as_percent_of_land > 75 THEN 1 END) AS quartile_4
FROM t1;

-- (d) List of countries in the 4th quartile (percent forest > 75%) in 2016
SELECT country_name, region, forest_as_percent_of_land
FROM forestation
WHERE year = 2016
AND country_name <> 'World'
AND forest_as_percent_of_land > 75
ORDER BY forest_as_percent_of_land DESC;

-- (e) Number of countries with higher forestation than the United States in 2016
SELECT COUNT(*)
FROM forestation
WHERE year = 2016
AND country_name <> 'World'
AND forest_as_percent_of_land > (
    SELECT forest_as_percent_of_land
    FROM forestation
    WHERE year = 2016
    AND country_name = 'United States'
);
