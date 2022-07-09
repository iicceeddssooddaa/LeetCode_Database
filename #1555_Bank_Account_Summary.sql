WITH t AS (
    SELECT paid_by AS user_id, -amount AS amount FROM Transactions
    UNION ALL
    SELECT paid_to AS user_id, amount FROM Transactions
)
SELECT DISTINCT Users.user_id, user_name, credit + COALESCE(SUM(amount) OVER (PARTITION BY Users.user_id),0) AS credit, CASE
    WHEN credit + COALESCE(SUM(amount) OVER (PARTITION BY Users.user_id),0) >= 0 THEN 'No'
    ELSE 'Yes' END AS credit_limit_breached
FROM Users
LEFT OUTER JOIN t ON Users.user_id = t.user_id;
