WITH t1 AS (
    SELECT employee_id FROM Employees WHERE manager_id = 1 AND employee_id != 1
),
t2 AS (
    SELECT employee_id FROM Employees WHERE manager_id IN (SELECT * FROM t1)
),
t3 AS (
    SELECT employee_id FROM Employees WHERE manager_id IN (SELECT * FROM t2)
)
SELECT employee_id FROM t1
UNION
SELECT employee_id FROM t2
UNION
SELECT employee_id FROM t3
--------------------
SELECT e1.employee_id
FROM Employees AS e1
INNER JOIN Employees AS e2 ON e1.manager_id = e2.employee_id
INNER JOIN Employees AS e3 ON e2.manager_id = e3.employee_id
WHERE (e1.manager_id = 1 OR e2.manager_id = 1 OR e3.manager_id = 1) AND NOT (e1.employee_id = 1);
