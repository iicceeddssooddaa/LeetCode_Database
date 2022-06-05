SELECT name AS Employee
FROM (SELECT e1.name, e1.salary, e2.salary AS manager_sal
    FROM Employee AS e1
    LEFT OUTER JOIN Employee AS e2 ON e1.managerID = e2.id) AS t
WHERE salary > manager_sal
ORDER BY name;
