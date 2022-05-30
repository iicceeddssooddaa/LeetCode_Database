WITH t AS (
    SELECT 
        id, 
        temperature > LAG(temperature) OVER (ORDER BY recordDate) AS temp_flag,
        DATEDIFF(recordDate, LAG(recordDate) OVER (ORDER BY recordDate)) = 1 AS date_flag
    FROM Weather
)
SELECT id
FROM t
WHERE temp_flag AND date_flag
