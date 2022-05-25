WITH t1 AS (
    SELECT 
        DISTINCT company_id, 
        CASE
            WHEN MAX(salary) OVER (PARTITION BY company_id) < 1000 THEN 100
            WHEN MAX(salary) OVER (PARTITION BY company_id) > 10000 THEN 51
            ELSE 76
        END AS rate
    FROM Salaries
)
SELECT Salaries.company_id, employee_id, employee_name, ROUND(salary * rate / 100) AS salary
FROM Salaries
LEFT OUTER JOIN t1 ON Salaries.company_id = t1.company_id
