WITH t AS (
    SELECT customer_id, GROUP_CONCAT(DISTINCT product_key ORDER BY product_key) AS products
    FROM Customer
    GROUP BY customer_id
)
SELECT customer_id
FROM t
WHERE t.products IN (SELECT GROUP_CONCAT(DISTINCT product_key ORDER BY product_key) FROM Product)
ORDER By customer_id;
