WITH t1 AS (
    SELECT DISTINCT paid_by AS user_id, SUM(-amount) OVER (PARTITION BY paid_by) AS paid
    FROM Transactions
),
t2 AS (
    SELECT DISTINCT paid_to AS user_id, SUM(amount) OVER (PARTITION BY paid_to) AS received
    FROM Transactions
)
SELECT 
    Users.user_id, user_name, credit + COALESCE(paid,0) + COALESCE(received,0) AS credit,
    CASE
        WHEN credit + COALESCE(paid,0) + COALESCE(received,0) >= 0 THEN 'No'
        ELSE 'Yes'
    END AS credit_limit_breached
FROM Users
LEFT OUTER JOIN t1 ON Users.user_id = t1.user_id
LEFT OUTER JOIN t2 ON Users.user_id = t2.user_id
ORDER BY user_id;
