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
