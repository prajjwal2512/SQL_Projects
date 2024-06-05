Select * from corona

-- Q1. Write a code to check NULL values

SELECT
    'province' AS column_name,
    COUNT(*) AS total_rows,
    SUM(CASE WHEN province IS NULL THEN 1 ELSE 0 END) AS null_values
FROM corona
UNION ALL
SELECT
    'country_region' AS column_name,
    COUNT(*) AS total_rows,
    SUM(CASE WHEN country_region IS NULL THEN 1 ELSE 0 END) AS null_values
FROM corona
UNION ALL
SELECT
    'latitude' AS column_name,
    COUNT(*) AS total_rows,
    SUM(CASE WHEN latitude IS NULL THEN 1 ELSE 0 END) AS null_values
FROM corona
UNION ALL
SELECT
    'longitude' AS column_name,
    COUNT(*) AS total_rows,
    SUM(CASE WHEN longitude IS NULL THEN 1 ELSE 0 END) AS null_values
FROM corona
UNION ALL
SELECT
    'date' AS column_name,
    COUNT(*) AS total_rows,
    SUM(CASE WHEN date IS NULL THEN 1 ELSE 0 END) AS null_values
FROM corona
UNION ALL
SELECT
    'confirmed' AS column_name,
    COUNT(*) AS total_rows,
    SUM(CASE WHEN confirmed IS NULL THEN 1 ELSE 0 END) AS null_values
FROM corona
UNION ALL
SELECT
    'deaths' AS column_name,
    COUNT(*) AS total_rows,
    SUM(CASE WHEN deaths IS NULL THEN 1 ELSE 0 END) AS null_values
FROM corona
UNION ALL
SELECT
    'recovered' AS column_name,
    COUNT(*) AS total_rows,
    SUM(CASE WHEN recovered IS NULL THEN 1 ELSE 0 END) AS null_values
FROM corona

--Q2. If NULL values are present, update them with zeros for all columns. 

UPDATE corona
SET
    province = COALESCE(province, 'unknown'),  -- Assuming province is a string
    country_region = COALESCE(country_region, 'unknown'),  -- Assuming country_region is a string
    latitude = COALESCE(latitude, 0),  -- Assuming latitude is a numeric value
    longitude = COALESCE(longitude, 0),  -- Assuming longitude is a numeric value
    date = COALESCE(date, '0001-01-01'::date),  -- Assuming date is a date type
    confirmed = COALESCE(confirmed, 0),  -- Assuming confirmed is a numeric value
    deaths = COALESCE(deaths, 0),  -- Assuming deaths is a numeric value
    recovered = COALESCE(recovered, 0);  -- Assuming recovered is a numeric value

-- Q3. check total number of rows

SELECT COUNT(*) AS total_rows
FROM corona;

-- Q4. Check what is start_date and end_date

SELECT 
    MIN(date) AS start_date,
    MAX(date) AS end_date
FROM 
    corona;


-- Q5. Number of month present in dataset
SELECT 
    COUNT(DISTINCT TO_CHAR(date, 'YYYY-MM')) AS number_of_months
FROM 
    corona;

-- Q6. Find monthly average for confirmed, deaths, recovered

SELECT 
    TO_CHAR(date, 'YYYY-MM') AS month,
    AVG(confirmed) AS avg_confirmed,
    AVG(deaths) AS avg_deaths,
    AVG(recovered) AS avg_recovered
FROM 
    corona
GROUP BY 
    TO_CHAR(date, 'YYYY-MM')
ORDER BY 
    month;


-- Q7. Find most frequent value for confirmed, deaths, recovered each month 

WITH monthly_data AS (
    SELECT
        date_trunc('month', date) AS month,
        confirmed,
        deaths,
        recovered
    FROM
        corona
),
most_frequent AS (
    SELECT
        month,
        confirmed,
        deaths,
        recovered,
        ROW_NUMBER() OVER (PARTITION BY month ORDER BY frequency DESC) AS rn
    FROM (
        SELECT
            month,
            confirmed,
            deaths,
            recovered,
            COUNT(*) AS frequency
        FROM
            monthly_data
        GROUP BY
            month,
            confirmed,
            deaths,
            recovered
    ) AS subquery
)
SELECT
    month,
    confirmed AS most_frequent_confirmed,
    deaths AS most_frequent_deaths,
    recovered AS most_frequent_recovered
FROM
    most_frequent
WHERE
    rn = 1
ORDER BY
    month;


-- Q8. Find minimum values for confirmed, deaths, recovered per year
SELECT
    date_part('year', date) AS year,
    MIN(confirmed) AS min_confirmed,
    MIN(deaths) AS min_deaths,
    MIN(recovered) AS min_recovered
FROM
    corona
GROUP BY
    date_part('year', date)
ORDER BY
    year;

-- Q9. Find maximum values of confirmed, deaths, recovered per year

SELECT
    date_part('year', date) AS year,
    MAX(confirmed) AS max_confirmed,
    MAX(deaths) AS max_deaths,
    MAX(recovered) AS max_recovered
FROM
    corona
GROUP BY
    date_part('year', date)
ORDER BY
    year;

-- Q10. The total number of case of confirmed, deaths, recovered each month
SELECT
    date_trunc('month', date) AS month,
    SUM(confirmed) AS total_confirmed,
    SUM(deaths) AS total_deaths,
    SUM(recovered) AS total_recovered
FROM
    corona
GROUP BY
    date_trunc('month', date)
ORDER BY
    month;

-- Q11. Check how corona virus spread out with respect to confirmed case
--      (Eg.: total confirmed cases, their average, variance & STDEV )

SELECT
    SUM(confirmed) As total_confirmed,
    AVG(confirmed) AS average_confirmed,
    VARIANCE(confirmed) AS variance_confirmed,
    STDDEV(confirmed) AS stdev_confirmed
FROM
    corona;

-- Q12. Check how corona virus spread out with respect to death case per month
--      (Eg.: total confirmed cases, their average, variance & STDEV )

SELECT
    date_trunc('month', date) AS month,
    SUM(deaths) AS total_deaths,
    AVG(deaths) AS average_deaths,
    VARIANCE(deaths) AS variance_deaths,
    STDDEV(deaths) AS stdev_deaths
FROM
    corona
GROUP BY
    date_trunc('month', date)
ORDER BY
    month;


-- Q13. Check how corona virus spread out with respect to recovered case
--      (Eg.: total confirmed cases, their average, variance & STDEV )

SELECT
    SUM(recovered) AS total_recovered,
    AVG(recovered) AS average_recovered,
    VARIANCE(recovered) AS variance_recovered,
    STDDEV(recovered) AS stdev_recovered
FROM
    corona;

-- Q14. Find Country having highest number of the Confirmed case
SELECT
    country_region,
    SUM(confirmed) AS total_confirmed
FROM
    corona
GROUP BY
    country_region
ORDER BY
    total_confirmed DESC
LIMIT 1;






-- Q15. Find Country having lowest number of the death case
SELECT
    country_region,
    SUM(deaths) AS total_deaths
FROM
    corona
GROUP BY
    country_region
ORDER BY
    total_deaths ASC
LIMIT 1;


-- Q16. Find top 5 countries having highest recovered case

SELECT
    country_region,
    SUM(recovered) AS total_recovered
FROM
    corona
GROUP BY
    country_region
ORDER BY
    total_recovered DESC
LIMIT 5;













	
	
	
	
	
	
	
	
	
	
	
	
	
	
	


