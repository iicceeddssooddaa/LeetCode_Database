WITH t AS (
    SELECT DISTINCT company_id, CASE
        WHEN MAX(salary) OVER (PARTITION BY company_id) > 10000 THEN .51
        WHEN MAX(salary) OVER (PARTITION BY company_id) < 1000 THEN 1
        ELSE .76
        END AS rate
    FROM Salaries
)
SELECT s.company_id, employee_id, employee_name, ROUND(salary * rate) AS salary
FROM Salaries AS s
LEFT OUTER JOIN t ON s.company_id = t.company_id;
