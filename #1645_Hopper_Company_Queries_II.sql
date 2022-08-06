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
t3 AS (
    SELECT month, 
        (SELECT COUNT(driver_id) FROM Drivers WHERE MONTH(join_date) <= month AND YEAR(join_date) = 2020) 
        + (SELECT COUNT(driver_id) FROM Drivers WHERE YEAR(join_date) < 2020) AS active_drivers
    FROM t1
),
t4 AS (
    SELECT driver_id, MONTH(requested_at) AS month
    FROM Rides
    RIGHT OUTER JOIN AcceptedRides ON Rides.ride_id = AcceptedRides.ride_id
    WHERE YEAR(requested_at) = 2020
),
t5 AS (
    SELECT t1.month, COUNT(DISTINCT t4.driver_id) AS accepted_rides
    FROM t2, t4
    RIGHT OUTER JOIN t1 ON t1.month = t4.month
    WHERE t2.driver_id = t4.driver_id AND t4.month >= t2.join_month
    GROUP BY t1.month
)

SELECT t3.month,  ROUND(COALESCE(accepted_rides/active_drivers * 100, 0),2) AS working_percentage
FROM t3
LEFT OUTER JOIN t5 ON t3.month = t5.month;
