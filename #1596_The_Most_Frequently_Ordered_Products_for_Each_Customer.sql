WITH t1 AS (
    SELECT 
        customer_id, product_id, 
        COUNT(*) OVER(PARTITION BY customer_id, product_id) AS ct
    FROM
        Orders
),
t2 AS (
    SELECT customer_id, product_id, ct, MAX(ct) OVER (PARTITION BY customer_id) AS max_ct
    FROM t1
)
SELECT DISTINCT customer_id, t2.product_id, product_name
FROM t2
LEFT OUTER JOIN Products
ON t2.product_id = Products.product_id
WHERE ct = max_ct
ORDER BY customer_id, product_id;
