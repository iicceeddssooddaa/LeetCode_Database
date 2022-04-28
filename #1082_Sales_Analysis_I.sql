WITH t1 AS (
    SELECT 
        seller_id, SUM(price) AS total
    FROM
        Sales
    GROUP BY
        seller_id
)
SELECT
    seller_id
FROM
    t1
WHERE total = (SELECT MAX(total) FROM t1)
