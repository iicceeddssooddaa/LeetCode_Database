WITH t AS (
    SELECT managerId, COUNT(managerID) 
    FROM Employee 
    GROUP BY managerID 
    HAVING COUNT(managerID) >= 5
)
SELECT name
FROM Employee
INNER JOIN t ON Employee.id = t.managerID
