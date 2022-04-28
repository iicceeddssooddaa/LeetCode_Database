WITH t1 AS (
    SELECT
        name, salary, managerId
    FROM
        Employee
    WHERE
        (managerID IS NOT NULL) AND
        (managerID IN (SELECT id FROM Employee))
),
t2 AS (
    SELECT
        t1.*, Employee.salary AS man_salary
    FROM t1
    LEFT OUTER JOIN Employee ON t1.managerID = Employee.id
)
SELECT name AS Employee
FROM t2
WHERE salary > man_salary
