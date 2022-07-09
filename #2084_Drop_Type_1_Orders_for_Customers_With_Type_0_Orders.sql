SELECT order_id, customer_id, order_type
FROM Orders
WHERE (customer_id NOT IN (
    SELECT DISTINCT customer_id
    FROM Orders
    WHERE order_type = 0
)) OR (order_type != 1)
-------
(SELECT order_id, customer_id, 0 AS order_type FROM Orders WHERE NOT order_type)
UNION
(SELECT order_id, customer_id, 1 AS order_type FROM Orders
WHERE customer_id NOT IN (SELECT customer_id FROM Orders WHERE NOT order_type))
