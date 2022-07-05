SELECT DISTINCT product_id, SUM(quantity) OVER (PARTITION BY product_id) AS total_quantity
FROM Sales;
