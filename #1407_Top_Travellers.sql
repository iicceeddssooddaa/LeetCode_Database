SELECT name, COALESCE(travelled_distance,0) AS travelled_distance
FROM Users
LEFT OUTER JOIN (SELECT user_id, SUM(distance) AS travelled_distance FROM Rides GROUP BY user_id) AS t ON Users.id = t.user_id
ORDER BY travelled_distance DESC, name ASC;
