WITH t AS (
    SELECT DISTINCT user_id, activity_date
    FROM Activity
    WHERE DATEDIFF('2019-07-27', activity_date) BETWEEN 0 AND 29
)
SELECT DISTINCT activity_date AS day, COUNT(user_id) OVER (PARTITION BY activity_date) AS active_users
FROM t;
