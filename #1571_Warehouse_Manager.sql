WITH temp AS (
    SELECT
        Warehouse.*,
        Products.Width, Products.Length, Products.Height
    FROM
        Warehouse
    LEFT JOIN Products On Warehouse.product_id = Products.product_id
)
SELECT
    name AS warehouse_name, 
    SUM(units * Width * Length * Height) AS volume
FROM temp
GROUP BY
    name
