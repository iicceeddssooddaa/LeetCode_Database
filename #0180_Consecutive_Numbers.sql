WITH t AS (
    SELECT num, LAG(num) OVER (ORDER BY id) AS lag_1, LAG(num,2) OVER (ORDER BY id) AS lag_2
    FROM Logs
)
SELECT DISTINCT num AS ConsecutiveNums 
FROM t
WHERE num = lag_1 AND num = lag_2
