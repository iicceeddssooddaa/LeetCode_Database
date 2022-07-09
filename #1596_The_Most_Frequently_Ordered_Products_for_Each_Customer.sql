WITH t AS (
    SELECT customer_id, product_id, COUNT(1) AS cnt
    FROM Orders
    GROUP BY customer_id, product_id
)
SELECT DISTINCT customer_id, t.product_id, product_name
FROM t
LEFT OUTER JOIN Products ON Products.product_id = t.product_id
WHERE (customer_id, cnt) IN (SELECT customer_id, MAX(cnt) FROM t GROUP BY customer_id);
