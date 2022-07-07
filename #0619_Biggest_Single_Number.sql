WITH t AS (
    SELECT num
    FROM MyNumbers
    GROUP BY num
    HAVING COUNT(num) = 1
    ORDER BY num DESC
    LIMIT 1
)
SELECT IFNULL((SELECT num FROM t), NULL) AS num
