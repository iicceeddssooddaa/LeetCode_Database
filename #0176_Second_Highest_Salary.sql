WITH temp AS ( SELECT DISTINCT salary FROM Employee ORDER BY salary DESC LIMIT 2 )
SELECT 
    (CASE 
        WHEN COUNT(salary) > 1 THEN MIN(salary)
        ELSE NULL 
     END) AS SecondHighestSalary
FROM
    temp
-------------
WITH t AS (
    SELECT id, salary, DENSE_RANK() OVER (ORDER BY salary DESC) AS sal_rnk
    FROM Employee
)
SELECT IFNULL((SELECT DISTINCT salary AS SecondHighestSalary
FROM t
WHERE sal_rnk = 2), NULL) AS SecondHighestSalary;
-------------
WITH t AS (
    SELECT DISTINCT salary, DENSE_RANK() OVER (ORDER BY salary DESC) AS sal_rank
    FROM Employee
)
SELECT IFNULL( (SELECT salary FROM t WHERE sal_rank = 2),NULL) AS SecondHighestSalary
