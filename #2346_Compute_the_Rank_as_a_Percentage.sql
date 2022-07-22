SELECT student_id, department_id, 
    ROUND(COALESCE((RANK() OVER (PARTITION BY department_id ORDER BY mark DESC) - 1)/(COUNT(1) OVER (PARTITION BY department_id) - 1) * 100,0), 2) AS percentage
FROM Students;
