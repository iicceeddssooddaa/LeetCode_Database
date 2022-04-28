WITH t1 AS (
    SELECT
        product_id, DATE_FORMAT(order_date, "%Y-%m") AS month, unit
    FROM 
        Orders
    WHERE order_date BETWEEN "2020-02-01" AND "2020-02-29"
),
t2 AS (
    SELECT
        product_id, SUM(unit) AS total
    FROM
        t1
    GROUP BY product_id
)
SELECT
    product_name, t2.total AS unit
FROM
    Products
LEFT OUTER JOIN t2 ON Products.product_id = t2.product_id
WHERE t2.total >= 100
