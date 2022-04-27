WITH p AS(
    SELECT
        project_id,
        Employee.experience_years
    FROM
        Project
    LEFT JOIN Employee ON Project.employee_id = Employee.employee_id
)

SELECT
    project_id,
    ROUND(SUM(experience_years)/COUNT(*),2) AS average_years
FROM 
    p
GROUP BY
    project_id
ORDER BY
    project_id
