WITH t1 AS (
    SELECT 
        DISTINCT DATE_FORMAT(trans_date, "%Y-%m") AS month, 
        country, COUNT(id) OVER (PARTITION BY country, DATE_FORMAT(trans_date, "%Y-%m")) AS trans_count,
        SUM(amount) OVER (PARTITION BY country, DATE_FORMAT(trans_date, "%Y-%m")) AS trans_total_amount
    FROM Transactions
),
t2 AS (
    SELECT 
        DISTINCT DATE_FORMAT(trans_date, "%Y-%m") AS month, 
        country, COUNT(id) OVER (PARTITION BY country, DATE_FORMAT(trans_date, "%Y-%m")) AS approved_count,
        SUM(amount) OVER (PARTITION BY country, DATE_FORMAT(trans_date, "%Y-%m")) AS approved_total_amount
    FROM Transactions
    WHERE state = 'approved'
)
SELECT 
    t1.month, t1.country, trans_count, COALESCE(approved_count, 0) AS approved_count, 
    trans_total_amount, COALESCE(approved_total_amount, 0) AS approved_total_amount
FROM t1
LEFT OUTER JOIN t2
ON t1.month = t2.month AND t1.country = t2.country
ORDER BY month, country;
