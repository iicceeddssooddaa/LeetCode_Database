WITH t1 AS (
    SELECT DISTINCT student_id FROM Exam
),
t2 AS (
    SELECT 
        exam_id, student_id,
        score = (MIN(score) OVER (PARTITION BY exam_id)) AS min_score_flag, 
        score = (MAX(score) OVER (PARTITION BY exam_id)) AS max_score_flag
    FROM Exam
),
t3 AS (
    SELECT DISTINCT student_id
    FROM t2
    WHERE min_score_flag OR max_score_flag
)
SELECT t1.student_id, student_name
FROM t1
LEFT OUTER JOIN Student ON t1.student_id = Student.student_id
WHERE t1.student_id NOT IN (SELECT student_id FROM t3)
ORDER BY t1.student_id;
