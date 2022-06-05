WITH t AS 
    (
    SELECT
        customer_number, COUNT(order_number) AS cnt
    FROM
        Orders
    GROUP BY 
        customer_number
    ORDER BY cnt DESC)

SELECT customer_number
FROM t
LIMIT 1;
----------
WITH t AS (
    SELECT 
        DISTINCT customer_number, 
        COUNT(order_number) OVER (PARTITION BY customer_number) AS order_number
    FROM Orders
    ORDER BY order_number DESC
)
SELECT customer_number
FROM t
LIMIT 1;
