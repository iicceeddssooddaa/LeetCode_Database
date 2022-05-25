WITH t AS (
    SELECT dept_id, COUNT(student_id) AS student_number
    FROM Student
    GROUP BY dept_id
)

SELECT dept_name, COALESCE(student_number, 0) AS student_number
FROM t
RIGHT OUTER JOIN Department
ON Department.dept_id = t.dept_id
ORDER BY student_number DESC, dept_name
