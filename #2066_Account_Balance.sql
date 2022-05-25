WITH t AS (
    SELECT account_id, day, 
        CASE 
            WHEN type = 'Withdraw' THEN -amount
            ELSE amount
        END AS increment
    FROM Transactions
)
SELECT 
    account_id, day, 
    SUM(increment) OVER (PARTITION BY account_id ORDER BY day) AS balance
FROM t
ORDER BY account_id, day
