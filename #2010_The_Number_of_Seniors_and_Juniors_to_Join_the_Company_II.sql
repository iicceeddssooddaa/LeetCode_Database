WITH t1 AS (
    SELECT employee_id, salary, 70000 - SUM(salary) OVER (PARTITION BY experience ORDER BY salary) AS remaining, 70000 - SUM(salary) OVER (PARTITION BY experience ORDER BY salary) >=0 AS s_flag
    FROM Candidates
    WHERE experience = 'Senior'
),
t2 AS (
    SELECT employee_id, salary, IFNULL((SELECT MIN(remaining) AS remaining_budget FROM t1 WHERE s_flag),70000) - SUM(salary) OVER (PARTITION BY experience ORDER BY salary) >=0 AS j_flag
    FROM Candidates
    WHERE experience = 'Junior'
)
SELECT employee_id FROM t1 WHERE s_flag
UNION
SELECT employee_id FROM t2 WHERE j_flag
