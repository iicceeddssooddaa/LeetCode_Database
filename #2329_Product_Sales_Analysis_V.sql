WITH t AS (
    SELECT user_id, SUM(SUM(quantity * price)) OVER (PARTITION BY user_id) AS spending
    FROM Sales
    LEFT OUTER JOIN Product ON Sales.product_id = Product.product_id
    GROUP BY user_id
)
SELECT user_id, spending
FROM t
ORDER BY spending DESC, user_id;
