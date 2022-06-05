SELECT class
FROM Courses
GROUP BY class
HAVING COUNT(class) >=5;
-------------
WITH t AS (
    SELECT DISTINCT class, COUNT(student) OVER (PARTITION BY class) AS cnt
    FROM Courses
)
SELECT class
FROM t
WHERE cnt >= 5;
