WITH temp1 AS (
    SELECT
        player_id, MIN(event_date) AS first_date
    FROM
        Activity
    GROUP BY
        player_id
)
    SELECT
        temp1.player_id, device_id
    FROM
        Activity
    INNER JOIN temp1 ON
        (Activity.player_id = temp1.player_id) AND
        (Activity.event_date = temp1.first_date)
-----------------------
WITH t AS (
    SELECT 
        DISTINCT player_id, MIN(event_date) OVER (PARTITION BY player_id) AS first_login
    FROM Activity
)
SELECT t.player_id, device_id
FROM Activity
INNER JOIN t ON Activity.player_id = t.player_id AND Activity.event_date = t.first_login;
