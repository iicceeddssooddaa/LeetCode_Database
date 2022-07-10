SELECT DISTINCT r1.driver_id, COALESCE(cnt,0) AS cnt
FROM Rides AS r1
LEFT OUTER JOIN (SELECT passenger_id, COUNT(1) AS cnt FROM Rides GROUP BY passenger_id) AS r2 ON r1.driver_id = r2.passenger_id;
