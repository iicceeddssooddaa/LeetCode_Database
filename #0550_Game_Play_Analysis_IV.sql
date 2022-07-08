WITH t AS (
    SELECT player_id, DATEDIFF(event_date, MIN(event_date) OVER (PARTITION BY player_id ORDER BY event_date)) = 1 AS flag
    FROM Activity
)
SELECT ROUND( (SELECT COUNT(DISTINCT player_id) FROM t WHERE flag)  / ( COUNT(DISTINCT player_id) ),2) AS fraction
FROM Activity;
