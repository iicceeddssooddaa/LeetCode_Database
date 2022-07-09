WITH t AS (
    (SELECT user_id, DATEDIFF(visit_date, LAG(visit_date) OVER (PARTITION BY user_id ORDER BY visit_date)) AS len
    FROM UserVisits)
    UNION ALL
    (SELECT DISTINCT user_id, DATEDIFF('2021-1-1', MAX(visit_date) OVER (PARTITION BY user_id)) AS len FROM UserVisits)
)
SELECT DISTINCT user_id, len AS biggest_window
FROM t
WHERE (user_id, len) IN (SELECT DISTINCT user_id, MAX(len) OVER (PARTITION BY user_id) FROM t)
ORDER BY user_id;
