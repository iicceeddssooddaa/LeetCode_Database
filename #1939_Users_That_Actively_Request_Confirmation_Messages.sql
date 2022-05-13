WITH t1 AS (
    SELECT user_id, 
    TIME_TO_SEC(TIMEDIFF(time_stamp, LAG(time_stamp) OVER (PARTITION BY user_id
                                          ORDER BY time_stamp))) AS time_diff
    FROM Confirmations
),
t2 AS (
    SELECT user_id, MIN(time_diff) OVER (PARTITION BY user_id) AS shortest_window
    FROM t1
)
SELECT DISTINCT user_id
FROM t2
WHERE shortest_window <= 86400;
