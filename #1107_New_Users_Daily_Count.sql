WITH t1 AS (
    SELECT user_id, activity_date, MIN(activity_date) OVER (PARTITION BY user_id) AS first_login
    FROM Traffic
    WHERE activity = 'login'
),
t2 AS (
    SELECT DISTINCT user_id
    FROM t1
    WHERE DATEDIFF('2019-06-30',first_login) > 90
),
t3 AS (
    SELECT DISTINCT user_id, activity_date, MIN(activity_date) OVER (PARTITION BY user_id) AS first_login
    FROM Traffic
    WHERE activity = 'login' AND user_id NOT IN (SELECT user_id FROM t2)
),
t4 AS (
    SELECT user_id, first_login
    FROM t3
    WHERE activity_date = first_login
)
SELECT DISTINCT first_login AS login_date, COUNT(user_id) OVER (PARTITION BY first_login) AS user_count
FROM t4
ORDER BY login_date;
