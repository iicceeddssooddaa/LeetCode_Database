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
