WITH t1 AS (
    SELECT student_id, course_id, grade, MAX(grade) OVER (PARTITION BY student_id) AS max_grade
    FROM Enrollments
),
t2 AS (
    SELECT student_id, course_id, grade
    FROM t1
    WHERE grade = max_grade
    ORDER BY student_id, course_id
)
SELECT DISTINCT student_id, MIN(course_id) OVER (PARTITION BY student_id) AS course_id, grade 
FROM t2
ORDER BY student_id
