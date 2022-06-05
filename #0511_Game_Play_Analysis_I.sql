WITH t AS (
    SELECT 
        DISTINCT player_id, 
        MIN(event_date) OVER (PARTITION BY player_id) AS first_login
    FROM Activity
)
SELECT player_id, first_login
FROM t
ORDER By player_id;
