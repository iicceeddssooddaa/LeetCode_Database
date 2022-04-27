WITH o AS (
    SELECT 
        COUNT(sale_date) AS sale_count,
        seller_id
    FROM
        Orders
    WHERE 
        sale_date BETWEEN "2020-01-01" AND "2020-12-31"
    GROUP BY 
        seller_id
)
SELECT 
    seller_name
FROM 
    Seller
LEFT OUTER JOIN o ON Seller.seller_id = o.seller_id
WHERE 
    (sale_count IS NULL) OR
    (sale_count = 0)
ORDER By seller_name
