WITH t AS (
    SELECT id1 AS airport_id, SUM(flights_count) = MAX(SUM(flights_count)) OVER () AS flag
    FROM ((SELECT departure_airport AS id1, arrival_airport AS id2, flights_count FROM Flights)
    UNION
    (SELECT arrival_airport AS id1, departure_airport AS id2, flights_count FROM Flights)) AS f
    GROUP BY id1
)
SELECT airport_id
FROM t
WHERE flag;
