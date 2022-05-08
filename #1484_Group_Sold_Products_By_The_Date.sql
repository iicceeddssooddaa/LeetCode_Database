WITH t AS (
    SELECT * FROM Activities
    ORDER BY sell_date, product
)
SELECT
    sell_date, COUNT(DISTINCT product) AS num_sold, GROUP_CONCAT(DISTINCT(product) SEPARATOR ',') AS products
FROM
    t
GROUP BY
    sell_date
ORDER BY
    sell_date
# PostgreSQL uses STRING_AGG instead 
