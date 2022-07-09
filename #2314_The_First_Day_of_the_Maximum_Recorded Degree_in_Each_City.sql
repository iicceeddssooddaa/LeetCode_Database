WITH t1 AS (
    SELECT DISTINCT city_id, day, degree, MAX(degree) OVER (PARTITION BY city_id) = MAX(degree) OVER (PARTITION BY city_id ORDER BY day) AS flag
    FROM Weather
),
t2 AS (
    SELECT city_id, day, degree, day = MIN(day) OVER (PARTITION BY city_id) AS new_flag
    FROM t1
    WHERE flag
)
SELECT DISTINCT city_id, day, degree
FROM t2
WHERE new_flag
ORDER BY city_id;
