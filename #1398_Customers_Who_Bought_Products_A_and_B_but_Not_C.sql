WITH a AS (
    SELECT DISTINCT customer_id
    FROM Orders
    WHERE product_name = 'A'
),
b AS (
    SELECT DISTINCT customer_id
    FROM Orders
    WHERE product_name = 'B'
),
t AS (
    SELECT a.customer_id
    FROM a
    INNER JOIN b ON a.customer_id = b.customer_id
    WHERE a.customer_id NOT IN (
    SELECT DISTINCT customer_id
    FROM Orders
    WHERE product_name = 'C'
)
)

SELECT t.customer_id, customer_name
FROM t
LEFT OUTER JOIN Customers
    ON t.customer_id = Customers.customer_id
---------------
SELECT c.customer_id, customer_name
FROM Customers AS c
INNER JOIN (SELECT DISTINCT customer_id FROM Orders WHERE product_name = 'A') AS a ON c.customer_id = a.customer_id
INNER JOIN (SELECT DISTINCT customer_id FROM Orders WHERE product_name = 'B') AS b ON c.customer_id = b.customer_id
WHERE c.customer_id NOT IN (SELECT DISTINCT customer_id FROM Orders WHERE product_name = 'C')
ORDER BY c.customer_id;
