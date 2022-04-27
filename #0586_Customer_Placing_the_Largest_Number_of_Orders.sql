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
