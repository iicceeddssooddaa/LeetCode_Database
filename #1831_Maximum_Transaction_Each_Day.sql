WITH t AS (
    SELECT transaction_id, amount, MAX(amount) OVER (PARTITION BY CAST(day AS DATE)) AS day_max
    FROM Transactions
)
SELECT transaction_id
FROM t
WHERE amount = day_max
ORDER BY transaction_id
--------
WITH t AS (
    SELECT transaction_id, amount = MAX(amount) OVER w AS flag
    FROM Transactions
    WINDOW w AS (PARTITION BY DATE_FORMAT(day, '%Y-%m-%d'))
)
SELECT transaction_id
FROM t
WHERE flag
ORDER BY transaction_id;
