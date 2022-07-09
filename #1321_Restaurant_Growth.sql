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
-------
WITH t AS (
    SELECT visited_on, SUM(amount) AS day_sum
    FROM Customer
    GROUP BY visited_on
)
SELECT t1.visited_on, SUM(t2.day_sum) AS amount, ROUND(AVG(t2.day_sum),2) AS average_amount 
FROM t AS t1, t AS t2
WHERE DATEDIFF(t1.visited_on, t2.visited_on) BETWEEN 0 AND 6
GROUP BY t1.visited_on
HAVING COUNT(t2.visited_on) =7
ORDER BY t1.visited_on;
