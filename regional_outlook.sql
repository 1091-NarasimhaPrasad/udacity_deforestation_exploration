-- (a) Percent forest of the entire world in 2016
SELECT country_name, forest_as_percent_of_land
FROM forestation
WHERE country_name = 'World' AND year = 2016;

-- Region with highest and lowest percent forest in 2016
SELECT region, 
       ROUND((SUM(forest_area_sqkm) / SUM(total_area_sqkm)) * 100, 2) AS region_percent
FROM forestation
WHERE year = 2016
GROUP BY region
ORDER BY region_percent DESC;

-- (b) Percent forest of the entire world in 1990
SELECT country_name, forest_as_percent_of_land
FROM forestation
WHERE country_name = 'World' AND year = 1990;

-- Region with highest and lowest percent forest in 1990
SELECT region, 
       ROUND((SUM(forest_area_sqkm) / SUM(total_area_sqkm)) * 100, 2) AS region_percent
FROM forestation
WHERE year = 1990
GROUP BY region
ORDER BY region_percent DESC;
