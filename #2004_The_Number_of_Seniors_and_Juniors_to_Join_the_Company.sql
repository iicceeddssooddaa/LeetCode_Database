WITH RECURSIVE s1 AS (
    SELECT employee_id, salary, SUM(salary) OVER (ORDER BY salary, employee_id) AS cum_salary, ROW_NUMBER () OVER (ORDER By salary) AS head_count
    FROM Candidates
    WHERE experience = 'Senior'
),
j1 AS (
    SELECT employee_id, salary, SUM(salary) OVER (ORDER BY salary, employee_id) AS cum_salary, ROW_NUMBER () OVER (ORDER By salary) AS head_count
    FROM Candidates
    WHERE experience = 'Junior'
),
s2 AS (
    SELECT cum_salary, head_count, 70000 - cum_salary AS remain
    FROM s1
    WHERE cum_salary <= 70000
),
j2 AS (
    SELECT cum_salary, head_count, 
        (CASE 
            WHEN (SELECT COUNT(*) FROM s2) = 0 THEN 70000
            ELSE (SELECT MIN(remain) FROM s2)
        END)- cum_salary AS remain
    FROM j1
    WHERE cum_salary <= (CASE 
            WHEN (SELECT COUNT(*) FROM s2) = 0 THEN 70000
            ELSE (SELECT MIN(remain) FROM s2)
        END)
),
t AS (
    (SELECT 'Senior' AS experience, (SELECT COUNT(*) FROM s2) AS accepted_candidates)
    UNION
    (SELECT 'Junior' AS experience, (SELECT COUNT(*) FROM j2) AS accepted_candidates)
)
SELECT * FROM t
