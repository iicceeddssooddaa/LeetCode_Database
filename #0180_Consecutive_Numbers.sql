WITH t AS (
    SELECT id, num, num = (LAG(num) OVER ()) AND num = (LAG(num,2) OVER ()) AS flag
    FROM Logs
)
SELECT DISTINCT num AS ConsecutiveNums
FROM t
WHERE flag;
