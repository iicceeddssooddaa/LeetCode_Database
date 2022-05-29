WITH t1 AS (
    SELECT name AS America, ROW_NUMBER() OVER () AS r_num
    FROM Student
    WHERE continent = 'America'
    ORDER BY name
),
t2 AS (
    SELECT name AS Asia, ROW_NUMBER() OVER () AS r_num
    FROM Student
    WHERE continent = 'Asia'
    ORDER BY name
),
t3 AS (
    SELECT name AS Europe, ROW_NUMBER() OVER () AS r_num
    FROM Student
    WHERE continent = 'Europe'
    ORDER BY name
)
SELECT America, Asia, Europe
FROM t1
LEFT OUTER JOIN t2 ON t1.r_num = t2.r_num
LEFT OUTER JOIN t3 ON t1.r_num = t3.r_num;
