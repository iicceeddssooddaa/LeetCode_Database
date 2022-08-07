WITH RECURSIVE t1 AS (
    SELECT 1 AS month UNION ALL (
    SELECT month + 1 FROM t1 WHERE month < 12
)),
t2 AS (
    SELECT driver_id, CASE WHEN YEAR(join_date) < 2020 THEN 1 
                            WHEN YEAR(join_date) = 2020 THEN MONTH(join_date) 
                            ELSE NULL END AS join_month
    FROM Drivers
),
t4 AS (
    SELECT driver_id, MONTH(requested_at) AS month, ride_distance, ride_duration 
    FROM Rides
    RIGHT OUTER JOIN AcceptedRides ON Rides.ride_id = AcceptedRides.ride_id
    WHERE YEAR(requested_at) = 2020
),
t5 AS (
    SELECT t1.month, SUM(ride_distance) AS dist_tot, SUM(ride_duration) AS dur_tot
    FROM t2, t4
    RIGHT OUTER JOIN t1 ON t1.month = t4.month
    WHERE t2.driver_id = t4.driver_id AND t4.month >= t2.join_month
    GROUP BY t1.month
)

SELECT t1.month, 
    ROUND(COALESCE(SUM(dist_tot) OVER (ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING)/3,0),2) AS average_ride_distance, 
    ROUND(COALESCE(SUM(dur_tot) OVER (ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING)/3,0),2) AS average_ride_duration
FROM t1
LEFT OUTER JOIN t5 ON t1.month = t5.month
LIMIT 10;
