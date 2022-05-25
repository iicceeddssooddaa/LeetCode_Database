# Write your MySQL query statement below
WITH t AS (
    SELECT DISTINCT user_id, activity_date
    FROM Activity   
)
SELECT DISTINCT activity_date AS day, COUNT(user_id) OVER (PARTITION BY activity_date) AS active_users
FROM t
WHERE DATEDIFF('2019-07-27', activity_date) < 30 AND DATEDIFF('2019-07-27', activity_date) >= 0;
