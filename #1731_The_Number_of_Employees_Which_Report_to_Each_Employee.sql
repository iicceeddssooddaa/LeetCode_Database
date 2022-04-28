WITH t1 AS (
    SELECT
        reports_to, ROUND(SUM(age)/ COUNT(age),0) AS average_age, COUNT(age) AS reports_count
    FROM
        Employees
    WHERE
        reports_to IS NOT NULL
    GROUP BY
        reports_to
)
SELECT
    employee_id, name, reports_count, average_age
FROM
    Employees
INNER JOIN t1 ON Employees.employee_id = t1.reports_to
ORDER BY employee_id
