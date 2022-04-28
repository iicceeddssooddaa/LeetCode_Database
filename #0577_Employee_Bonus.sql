WITH temp AS (
    SELECT
        name, bonus
    FROM
        Employee
    LEFT OUTER JOIN Bonus ON Employee.empID = Bonus.empID
)
SELECT
    name, bonus
FROM 
    temp
WHERE
    (bonus IS NULL) OR (bonus < 1000)
