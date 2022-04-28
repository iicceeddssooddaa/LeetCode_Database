WITH t1 AS (
    SELECT
        product_id, MIN(sale_date) AS earliest, MAX(sale_date) AS latest
    FROM
        Sales
    GROUP BY product_id

)
SELECT t1.product_id, Product.product_name
FROM 
    t1
LEFT OUTER JOIN Product ON t1.product_id = Product.product_id
WHERE (earliest > "2018-12-31") AND (latest < "2019-04-01")
