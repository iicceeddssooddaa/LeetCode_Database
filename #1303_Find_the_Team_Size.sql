WITH t AS
    (SELECT
        team_id, 
        COUNT(team_id) AS team_size
     FROM
        Employee
     GROUP BY team_id)
SELECT
    employee_id,
    t.team_size
FROM
    Employee
LEFT OUTER JOIN t ON Employee.team_id = t.team_id
