WITH m AS (
    SELECT DATE_FORMAT(trans_date, '%Y-%m') AS month, country FROM Transactions
    UNION
    (SELECT DATE_FORMAT(Chargebacks.trans_date, '%Y-%m') AS month, country FROM Chargebacks
    INNER JOIN Transactions ON Chargebacks.trans_id = Transactions.id)
),
t AS (
    SELECT id, country, state, amount, DATE_FORMAT(trans_date, '%Y-%m') AS month FROM Transactions
),
c AS (
    SELECT trans_id, DATE_FORMAT(trans_date, '%Y-%m') AS month FROM Chargebacks
),
t1 AS (
    SELECT 
        DISTINCT country, month,
        COUNT(*) OVER (PARTITION BY country, month) AS approved_count, 
        SUM(amount) OVER (PARTITION BY country, month) AS approved_amount
    FROM t
    WHERE state = 'approved'
),
t2 AS (
    SELECT 
        DISTINCT country, c.month, 
        COUNT(*) OVER (PARTITION BY country, c.month) AS chargeback_count,
        SUM(amount) OVER (PARTITION BY country, c.month) AS chargeback_amount
    FROM t
    INNER JOIN c ON t.id = c.trans_id
)
SELECT 
    m.month, m.country, 
    COALESCE(approved_count,0) AS approved_count, 
    COALESCE(approved_amount,0) AS approved_amount, 
    COALESCE(chargeback_count,0) AS chargeback_count, 
    COALESCE(chargeback_amount,0) AS chargeback_amount
FROM m
LEFT OUTER JOIN t1 ON m.month = t1.month AND m.country = t1.country
LEFt OUTER JOIN t2 ON m.month = t2.month AND m.country = t2.country
WHERE 
    COALESCE(approved_count,0) + COALESCE(approved_amount,0) + 
    COALESCE(chargeback_count,0) + COALESCE(chargeback_amount,0) !=0
ORDER By month, country;
