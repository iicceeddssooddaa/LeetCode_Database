WITH t1 AS (
    SELECT 
        user_id,
        DATEDIFF(visit_date, lag(visit_date) OVER (PARTITION BY user_id ORDER BY visit_date)) AS win_len
    FROM UserVisits
),
t2 AS (
    SELECT DISTINCT user_id,
        COALESCE(MAX(win_len) OVER (PARTITION BY user_id),0) AS big_win
    FROM t1
),
t3 AS (
    SELECT DISTINCT user_id,
        DATEDIFF('2021-01-01', MAX(visit_date) OVER (PARTITION BY user_id)) AS len_now
    FROM UserVisits
)
SELECT 
    t2.user_id, 
    CASE
        WHEN big_win >= len_now THEN big_win
        ELSE len_now
    END AS biggest_window
FROM t2
LEFT OUTER JOIN t3
ON t2.user_id = t3.user_id
ORDER BY t2.user_id
