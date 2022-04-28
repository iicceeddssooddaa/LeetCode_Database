WITH t1 AS (
    SELECT
        Sales.buyer_id, Product.product_name
    FROM
        Sales
    LEFT OUTER JOIN Product ON Sales.product_id = Product.product_id
    WHERE (product_name = "S8") OR (product_name = "iPhone")
),
t2 AS (
    SELECT
        buyer_id
    FROM t1
    WHERE product_name = "S8"
),
t3 AS (
    SELECT
        buyer_id
    FROM t1
    WHERE product_name = "iPhone"
)

SELECT DISTINCT buyer_id
FROM t2 
WHERE buyer_id NOT IN (SELECT * FROM t3)
ORDER BY buyer_id; 
