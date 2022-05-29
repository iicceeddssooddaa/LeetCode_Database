WITH t3 AS (
    SELECT 
        player_id, event_date,
        MIN(event_date) OVER (PARTITION BY player_id) AS install_dt,
        DATEDIFF(LEAD(event_date) OVER (PARTITION BY player_id ORDER BY event_date), event_date) AS diff
    FROM Activity
),
t4 AS (
    SELECT player_id, event_date, event_date = install_dt AS install_flag, diff = 1 AS ret_flag
    FROM t3
),
t AS (
    SELECT 
        DISTINCT event_date AS install_dt, SUM(install_flag) OVER (PARTITION BY event_date) AS installs, 
        COALESCE(ROUND(SUM(ret_flag) OVER (PARTITION BY event_date) / SUM(install_flag) OVER (PARTITION BY event_date),2),0) AS Day1_retention
    FROM t4
    WHERE install_flag
)

SELECT * FROM t
