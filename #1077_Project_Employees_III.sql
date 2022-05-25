WITH t AS (
    SELECT project_id, Project.employee_id, experience_years, 
        MAX(experience_years) OVER (PARTITION BY project_id) AS max_exp
    FROM Project
    LEFT OUTER JOIN Employee ON Project.employee_id = Employee.employee_id
)
SELECT project_id, employee_id
FROM t
WHERE experience_years = max_exp
ORDER BY project_id, employee_id
