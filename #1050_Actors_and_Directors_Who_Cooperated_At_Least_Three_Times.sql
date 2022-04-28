WITH t AS (
    SELECT
        actor_id, director_id, COUNT(timestamp) AS cnt
    FROM
        ActorDirector
    GROUP BY actor_id, director_id
)
SELECT
    actor_id, director_id
FROM
    t
WHERE cnt >= 3
