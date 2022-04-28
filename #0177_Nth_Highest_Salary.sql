CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
  RETURN (
      # Write your MySQL query statement below.
      WITH temp AS ( SELECT DISTINCT salary FROM Employee ORDER BY salary DESC LIMIT N )
SELECT 
    (CASE 
        WHEN COUNT(salary) >= N THEN MIN(salary)
        ELSE NULL 
     END) AS getNthHighestSalary
FROM
    temp
  );
END
