WITH t1 AS (
    (SELECT 
        DISTINCT departure_airport AS airport_id, 
        SUM(flights_count) OVER (PARTITION BY departure_airport) AS flights_count 
    FROM Flights)
    UNION
    (SELECT 
        DISTINCT arrival_airport AS airport_id, 
        SUM(flights_count) OVER (PARTITION BY arrival_airport) AS flights_count 
    FROM Flights)
),
t2 AS (
    SELECT DISTINCT airport_id, SUM(flights_count) OVER (PARTITION BY airport_id) AS total FROM t1
),
t3 AS (
    SELECT airport_id, total, RANK() OVER (ORDER BY total DESC) AS rank_total FROM t2
)
SELECT airport_id
FROM t3
WHERE rank_total = 1
ORDER BY airport_id;
