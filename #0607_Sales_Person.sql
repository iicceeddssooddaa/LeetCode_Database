WITH t1 AS (
    SELECT
        Orders.com_id, sales_id, name
    FROM
        Orders
    LEFT OUTER JOIN Company ON Orders.com_id = Company.com_id
),
t2 AS (
    SELECT sales_id FROM t1
    WHERE name = "RED"
)
SELECT
    name
FROM
    SalesPerson
WHERE sales_id NOT IN (SELECT * FROM t2)
