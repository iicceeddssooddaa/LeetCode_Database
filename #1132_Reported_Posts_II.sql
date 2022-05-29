WITH t1 AS (
    SELECT DISTINCT post_id, action_date, post_id IN (SELECT post_id FROM Removals) AS flag
    FROM Actions
    WHERE extra = 'spam' AND action_date IN (SELECT action_date FROM (
    SELECT DISTINCT action_date
    FROM Actions 
    WHERE extra = 'spam' 
) AS t)
),
t2 AS (
    SELECT 
        DISTINCT action_date, 
        100 * SUM(flag) OVER (PARTITION BY action_date) / COUNT(*) OVER (PARTITION BY action_date) AS remove_rate
    FROM t1
)

SELECT ROUND(AVG(remove_rate),2) AS average_daily_percent
FROM t2
