WITH t1 AS (
    SELECT 
        DISTINCT visited_on, 
        SUM(amount) OVER (PARTITION BY visited_on) AS amount,
        DATE(MIN(visited_on) OVER () + 6) AS start_date
    FROM Customer
),
t2 AS (
    SELECT 
        visited_on, start_date,
        SUM(amount) OVER (ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS amount,
        ROUND((SUM(amount) OVER (ROWS BETWEEN 6 PRECEDING AND CURRENT ROW))/7, 2) AS average_amount
    FROM t1
)
SELECT visited_on, amount, average_amount FROM t2
WHERE visited_on >= start_date
ORDER BY visited_on;
