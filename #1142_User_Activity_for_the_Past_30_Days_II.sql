WITH t AS (
    SELECT DISTINCT user_id, session_id
    FROM Activity
    WHERE DATEDIFF('2019-07-27',activity_date) < 30
)
SELECT ROUND(COALESCE( (SELECT COUNT(*) FROM t) / (SELECT COUNT(DISTINCT user_id) FROM t),0),2) AS average_sessions_per_user
