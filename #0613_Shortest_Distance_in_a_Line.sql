WITH temp AS (
    SELECT
        a.x AS num1, b.x AS num2
    FROM
        Point AS a
    JOIN Point AS b
),
diff AS (
    SELECT 
        ABS(num1 - num2) AS diff
    FROM
        temp
)
SELECT MIN(diff) AS shortest
FROM diff
WHERE diff != 0
------
WITH t1 AS (
    SELECT 
        x - LAG(x) OVER (ORDER BY x) AS diff
    FROM
        Point
)
SELECT MIN(diff) AS shortest
FROM t1
