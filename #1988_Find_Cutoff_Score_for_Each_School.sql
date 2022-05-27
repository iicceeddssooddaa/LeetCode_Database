SELECT 
    school_id, 
    COALESCE((SELECT MIN(score) FROM Exam WHERE student_count <= capacity), -1) AS score
FROM Schools;
