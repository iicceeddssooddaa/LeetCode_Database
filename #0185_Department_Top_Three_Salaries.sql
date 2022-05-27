WITH t AS (
    SELECT name, salary, departmentID, 
        DENSE_RANK() OVER(PARTITION BY departmentID ORDER BY salary DESC) AS sal_rank
    FROM Employee
)
SELECT d.name AS Department, t.name AS Employee, salary AS Salary
FROM t
LEFT OUTER JOIN Department AS d
ON d.id = t.departmentID
WHERE sal_rank <= 3
ORDER BY Department, Salary DESC;
