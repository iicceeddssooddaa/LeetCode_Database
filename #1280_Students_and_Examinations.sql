WITH e1 AS (
    SELECT
        student_id, subject_name, COUNT(*) AS attended_exams
    FROM
        Examinations
    GROUP BY student_id, subject_name
),
e2 AS (
SELECT
    student_id, student_name, subject_name 
FROM
    Students, Subjects
)
SELECT
    e2.*, COALESCE(attended_exams, 0) AS attended_exams
FROM e2
LEFT OUTER JOIN e1 ON 
    (e2.student_id = e1.student_id) AND
    (e2.subject_name = e1.subject_name)
ORDER BY
    student_id, subject_name
