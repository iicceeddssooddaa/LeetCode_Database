WITH t AS (
    SELECT transaction_id, amount, MAX(amount) OVER (PARTITION BY CAST(day AS DATE)) AS day_max
    FROM Transactions
)
SELECT transaction_id
FROM t
WHERE amount = day_max
ORDER BY transaction_id
