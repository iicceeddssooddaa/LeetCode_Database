WITH t1 AS (
    SELECT country_id, weather_state
    FROM Weather
    WHERE day BETWEEN "2019-11-01" AND "2019-11-30"
)
SELECT country_name, (CASE 
                        WHEN SUM(weather_state)/ COUNT(weather_state) <= 15 THEN "Cold"
                        WHEN SUM(weather_state)/ COUNT(weather_state) >= 25 THEN "Hot"
                        ELSE "Warm" END
) AS weather_type
FROM t1
LEFT OUTER JOIN Countries ON t1.country_id = Countries.country_id
GROUP BY t1.country_id
