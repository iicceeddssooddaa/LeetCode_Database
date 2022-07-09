WITH t AS (
    SELECT salary, DENSE_RANK() OVER (ORDER BY salary) AS team_id
    FROM Employees
    GROUP BY salary
    HAVING COUNT(salary) > 1
)
SELECT employee_id, name, t.salary, team_id
FROM t
LEFT OUTER JOIN Employees ON t.salary = Employees.salary
ORDER BY team_id, employee_id;
