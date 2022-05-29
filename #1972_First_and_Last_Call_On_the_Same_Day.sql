WITH t1 AS (
    SELECT caller_id AS user1, recipient_id AS user2, call_time FROM Calls
    UNION
    SELECT recipient_id AS user1, caller_id AS user2, call_time FROM Calls
),
t2 AS (
    SELECT 
        user1, user2, call_time, 
        DATE(call_time) AS call_day, 
        RANK() OVER (PARTITION BY user1, DATE(call_time) ORDER BY call_time) AS call_order,
        COUNT(*) OVER (PARTITION BY user1, DATE(call_time)) AS call_d_cnt
    FROM t1
),
t3 AS (
    SELECT
        user1, user2, call_time, call_day, call_order
    FROM t2
    WHERE (call_order = 1 OR call_order = call_d_cnt) AND call_d_cnt != 1
    ORDER BY user1, call_time
),
t4 AS (
    SELECT user1 AS user_id, user2 = LEAD(user2) OVER (PARTITION BY user1, call_day) AS flag
    FROM t3
)
(SELECT DISTINCT user_id
FROM t4
WHERE flag)
UNION 
(SELECT DISTINCT user1 AS user_id
FROM t2
WHERE call_d_cnt = 1)
