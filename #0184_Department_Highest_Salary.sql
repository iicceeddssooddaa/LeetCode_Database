WITH t AS (
    SELECT name, salary, MAX(salary) OVER (PARTITION BY departmentID) AS max_sal, departmentID
    FROM Employee
)
SELECT d.name AS Department, t.name AS Employee, salary AS Salary
FROM t
LEFT OUTER JOIN Department AS d
ON d.id = t.departmentID
WHERE salary = max_sal;
