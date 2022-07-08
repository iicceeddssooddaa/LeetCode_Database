WITH t AS (
    SELECT project_id, p.employee_id, experience_years = MAX(experience_years) OVER (PARTITION BY project_id) AS flag
    FROM Project AS p
    LEFT OUTER JOIN Employee AS e ON p.employee_id = e.employee_id
)
SELECT project_id, employee_id
FROM t
WHERE flag;
