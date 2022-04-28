WITH t1 AS (
    SELECT
        customer_id, DATE_FORMAT(order_date, "%Y-%m") AS month, SUM(Orders.quantity * Product.price) AS total
    FROM
        Orders
    LEFT OUTER JOIN Product ON Orders.product_id = Product.product_id
    GROUP BY
        customer_id, month
    
),
t2 AS (
    SELECT 
        t1.customer_id, Customers.name, total, month
    FROM
        t1
    LEFT OUTER JOIN Customers ON t1.customer_id = Customers.customer_id
    WHERE 
        month BETWEEN "2020-06" AND "2020-07"
),
t3 AS (
    SELECT *
    FROM t2
    WHERE
        month = "2020-06" AND total >= 100
),
t4 AS (
    SELECT *
    FROM t2
    WHERE
        month = "2020-07" AND total >= 100
)
SELECT t3.customer_id, t3.name
FROM t3
INNER JOIN t4 ON t3.customer_id = t4.customer_id
