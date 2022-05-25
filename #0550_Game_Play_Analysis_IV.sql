WITH t1 AS (
    SELECT player_id, DATEDIFF(event_date, MIN(event_date) OVER (PARTITION BY player_id ORDER BY event_date)) AS date_diff
    FROM Activity
    ORDER BY player_id
)
SELECT ROUND((SELECT COUNT(DISTINCT player_id) FROM t1 WHERE date_diff = 1)/ COUNT(DISTINCT player_id), 2) AS fraction
FROM Activity
