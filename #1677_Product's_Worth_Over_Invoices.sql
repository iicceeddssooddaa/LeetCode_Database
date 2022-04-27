WITH t AS 
    (SELECT 
        product_id, 
        SUM(rest) AS rest_sum, 
        SUM(paid) AS paid_sum, 
        SUM(canceled) AS canceld_sum, 
        SUM(refunded) AS refunded_sum
     FROM
        Invoice
    GROUP BY product_id)

SELECT
    Product.name, 
    COALESCE (t.rest_sum,0) AS rest, 
    COALESCE (t.paid_sum,0) AS paid, 
    COALESCE (t.canceld_sum,0) AS canceled, 
    COALESCE (t.refunded_sum,0) AS refunded
FROM
    Product
LEFT OUTER JOIN t ON Product.product_id = t.product_id
ORDER BY name
