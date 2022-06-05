WITH t AS (
    SELECT name, bonus
    FROM Employee
    LEFT OUTER JOIN Bonus ON Employee.empId = Bonus.empId
)
SELECT * FROM t
WHERE bonus IS NULL OR bonus < 1000; 
