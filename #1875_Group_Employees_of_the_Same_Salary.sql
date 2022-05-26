WITH t1 AS (
    SELECT salary, COUNT(salary) AS ct FROM Employees GROUP BY salary
    ORDER BY salary
),
t2 AS (
    SELECT salary, ROW_NUMBER() OVER () AS team_id
    FROM t1
    WHERE ct != 1
)

SELECT employee_id, name, Employees.salary, team_id
FROM Employees
LEFT OUTER JOIN t2
ON Employees.salary = t2.salary
WHERE Employees.salary IN (SELECT salary FROM t2)
ORDER BY team_id, employee_id;
