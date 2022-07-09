WITH t AS (
    SELECT 
        order_id, order_date, product_id,
        MAX(order_date) OVER (PARTITION BY product_id) AS latest
    FROM Orders
)
SELECT product_name, t.product_id, order_id, order_date
FROM t
LEFT OUTER JOIN Products
ON t.product_id = Products.product_id
WHERE order_date = latest
ORDER BY product_name, product_id, order_id;
----
SELECT product_name, Orders.product_id, order_id, order_date
FROM Orders
LEFT OUTER JOIN Products ON Orders.product_id = Products.product_id
WHERE (Orders.product_id, order_date) IN (SELECT DISTINCT product_id, MAX(order_date) OVER (PARTITION BY product_id) AS first_day FROM Orders)
ORDER BY product_name, product_id, order_id;
