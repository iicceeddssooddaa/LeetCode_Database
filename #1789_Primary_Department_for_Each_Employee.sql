WITH a AS (
    SELECT
        employee_id,
        department_id
    FROM
        Employee
    GROUP BY employee_id
    HAVING COUNT(employee_id) = 1
),
b AS (
    SELECT
        employee_id,
        department_id
    FROM
        Employee
    WHERE primary_flag = 'Y'
)
SELECT * FROM a
UNION
SELECT * FROM b
