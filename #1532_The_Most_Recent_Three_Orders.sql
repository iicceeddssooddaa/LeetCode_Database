WITH t AS (
    SELECT 
    customer_id, order_id, order_date, 
    ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date DESC) AS code
    FROM Orders
)
SELECT name AS customer_name, t.customer_id, order_id, order_date
FROM t
LEFT OUTER JOIN Customers ON t.customer_id = Customers.customer_id
WHERE code <= 3
ORDER BY customer_name, customer_id, order_date DESC
