WITH t1 AS (
    SELECT a.user_id, COALESCE(ROUND(confirmed_cnt/action_cnt,2),0) AS confirmation_rate
    FROM (
        SELECT DISTINCT user_id, COUNT(user_id) OVER (PARTITION BY user_id) AS action_cnt
        FROM Confirmations) AS a
    LEFT OUTER JOIN (
        SELECT DISTINCT user_id, COUNT(user_id) OVER (PARTITION BY user_id) AS confirmed_cnt
        FROM Confirmations
        WHERE action = 'confirmed') AS c
    ON a.user_id = c.user_id
)
SELECT Signups.user_id, COALESCE(confirmation_rate,0) AS confirmation_rate
FROM Signups
LEFT OUTER JOIN t1
ON Signups.user_id = t1.user_id
ORDER BY user_id;
