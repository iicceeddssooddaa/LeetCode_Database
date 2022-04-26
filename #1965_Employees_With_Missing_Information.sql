SELECT
    Temp.employee_id
FROM
    (SELECT
        *
    FROM
        Employees
     LEFT OUTER JOIN Salaries USING (employee_id)
     UNION
     SELECT
        *
     FROM
        Salaries
     LEFT OUTER JOIN Employees USING (employee_id)
    ) AS Temp
WHERE
    (name IS NULL) OR
    (salary IS NULL)
ORDER BY
    employee_id
