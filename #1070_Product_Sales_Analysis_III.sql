WITH t AS (
    SELECT sale_id, product_id, year, year = MIN(year) OVER (PARTITION BY product_id) AS flag, quantity, price
    FROM Sales
)
SELECT product_id, year AS first_year, quantity, price
FROM t
WHERE flag
ORDER By product_id;
----------------
SELECT product_id, year AS first_year, quantity, price
FROM Sales
WHERE (product_id, year) IN (SELECT product_id, MIN(year) FROM Sales GROUP BY product_id);
