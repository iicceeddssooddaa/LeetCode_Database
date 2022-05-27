WITH t AS (
    SELECT 
        id, company, salary, 
        ROW_NUMBER() OVER (PARTITION BY company ORDER BY salary) AS sal_rank,
        COUNT(*) OVER (PARTITION BY company) AS com_cnt
    FROM Employee
)
SELECT id, company, salary
FROM t
WHERE CASE
    WHEN com_cnt %2 != 0 THEN sal_rank = (com_cnt + 1) /2
    ELSE sal_rank = com_cnt/2 OR sal_rank = com_cnt/2 + 1
    END; 
