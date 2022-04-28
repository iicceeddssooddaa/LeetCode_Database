WITH temp AS ( SELECT DISTINCT salary FROM Employee ORDER BY salary DESC LIMIT 2 )
SELECT 
    (CASE 
        WHEN COUNT(salary) > 1 THEN MIN(salary)
        ELSE NULL 
     END) AS SecondHighestSalary
FROM
    temp
