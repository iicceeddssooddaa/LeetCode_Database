SELECT employee_id, CASE
    WHEN employee_id%2 AND NOT name REGEXP '^M' THEN salary
    ELSE 0
    END AS bonus
FROM Employees
ORDER BY employee_id;
