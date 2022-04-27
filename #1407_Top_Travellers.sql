WITH dist AS(
    SELECT
        user_id, SUM(distance) AS distance
    FROM
        Rides
    GROUP BY
        user_id
    ORDER BY
        user_id
)
SELECT
    Users.name,
    COALESCE (dist.distance,0) AS travelled_distance
FROM
    Users
LEFT OUTER JOIN dist ON Users.id = dist.user_id
ORDER BY
    travelled_distance DESC,
    name
