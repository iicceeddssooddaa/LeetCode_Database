WITH t AS (
    SELECT 
        id, visit_date, people,
        LAG(people,2) OVER () >=100 AS flag1, 
        LAG(people,1) OVER () >=100 AS flag2,
        people >= 100 AS flag3, 
        LEAD(people,1) OVER () >=100 AS flag4,
        LEAD(people,2) OVER () >=100 AS flag5
    FROM Stadium
)
SELECT id, visit_date, people
FROM t
WHERE 
    (flag1 AND flag2 AND flag3) OR
    (flag2 AND flag3 AND flag4) OR
    (flag3 AND flag4 AND flag5)
ORDER BY id;
