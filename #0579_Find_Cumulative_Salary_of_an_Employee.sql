WITH t2 AS (
    SELECT id, month, salary + 
    IF(LAG(month) OVER (PARTITION BY id ORDER BY month) = month -1, LAG(salary) OVER (PARTITION BY id ORDER BY month), 0) + 
    IF(LAG(month,2) OVER (PARTITION BY id ORDER BY month) = month -2, LAG(salary,2) OVER (PARTITION BY id ORDER BY month), 0) + IF(LAG(month) OVER (PARTITION BY id ORDER BY month) = month -2, LAG(salary) OVER (PARTITION BY id ORDER BY month), 0) AS salary_sum
    FROM Employee
    WHERE (id, month) NOT IN (SELECT id, MAX(month) AS month
    FROM Employee
    GROUP BY id)
)
SELECT id, month, salary_sum AS Salary
FROM t2
ORDER BY id, month DESC;
