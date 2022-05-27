WITH t1 AS (
    SELECT bus_id, COALESCE(LAG(arrival_time) OVER (ORDER BY arrival_time), -1) AS start_int, arrival_time
    FROM Buses
    ORDER BY arrival_time
),
t2 AS (
    SELECT bus_id, start_int, t1.arrival_time, passenger_id, Passengers.arrival_time AS p_time
    FROM t1
    LEFT OUTER JOIN Passengers 
        ON (start_int < Passengers.arrival_time) AND (Passengers.arrival_time <= t1.arrival_time)
)
SELECT DISTINCT bus_id, COUNT(passenger_id) OVER (PARTITION BY bus_id) AS passengers_cnt
FROM t2
ORDER BY bus_id;
