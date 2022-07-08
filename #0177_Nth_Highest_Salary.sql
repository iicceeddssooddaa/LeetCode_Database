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
------------
CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
  RETURN (
      # Write your MySQL query statement below.
      WITH t AS (
        SELECT DISTINCT salary, DENSE_RANK() OVER (ORDER BY salary DESC) AS sal_rnk
        FROM Employee
      )
      SELECT IFNULL( (SELECT salary FROM t WHERE sal_rnk = N) ,NULL) AS result
  );
END
