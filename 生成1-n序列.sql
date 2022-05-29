WITH RECURSIVE seq AS (
    SELECT 1 AS value 
    UNION ALL 
    SELECT value + 1 FROM seq WHERE value < n
)
SELECT * FROM seq;
