WITH driver AS ( SELECT DISTINCT driver_id FROM Rides),
passenger AS (
    SELECT
        passenger_id, COUNT(passenger_id) AS cnt
    FROM
        Rides
    WHERE
        (passenger_id IN (SELECT * FROM driver))
    GROUP BY
        passenger_id
)
SELECT
    driver_id, COALESCE(cnt,0) AS cnt
FROM
    driver
LEFT OUTER JOIN passenger ON driver_id = passenger_id
