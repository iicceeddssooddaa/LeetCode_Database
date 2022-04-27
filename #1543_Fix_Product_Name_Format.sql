WITH temp AS (
    SELECT
        TRIM(LOWER(product_name)) AS product_name,
        DATE_FORMAT(sale_date, "%Y-%m") AS sale_date,
        sale_id
    FROM
        Sales
)
SELECT
    product_name,
    sale_date,
    COUNT(*) AS total
FROM temp
GROUP BY
    product_name, sale_date
ORDER BY
    product_name,
    sale_date
