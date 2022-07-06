WITH t AS (
    SELECT country_id, AVG(weather_state) AS average_weather
    FROM Weather
    WHERE day BETWEEN '2019-11-01' AND '2019-11-30'
    GROUP BY country_id
)
SELECT country_name, CASE
    WHEN average_weather <=15 THEN 'Cold'
    WHEN average_weather >=25 THEN 'Hot'
    ELSE 'Warm'
    END AS weather_type
FROM t
LEFT OUTER JOIN Countries ON t.country_id = Countries.country_id;
