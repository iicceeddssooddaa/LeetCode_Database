WITH t AS (
    SELECT DISTINCT user_id, Sales.product_id, SUM(quantity * price) = MAX(SUM(quantity * price)) OVER (PARTITION BY user_id) AS flag
    FROM Sales
    LEFT OUTER JOIN Product ON Sales.product_id = Product.product_id
    GROUP BY user_id, Sales.product_id
)
SELECT user_id, product_id
FROM t
WHERE flag;
