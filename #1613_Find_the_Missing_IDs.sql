WITH RECURSIVE seq AS (
    SELECT 1 AS ids 
    UNION ALL 
    SELECT ids + 1 
    FROM seq 
    WHERE ids < (SELECT MAX(customer_id) FROM Customers)
)
SELECT * 
FROM seq
WHERE ids NOT IN (SELECT customer_id FROM Customers);
