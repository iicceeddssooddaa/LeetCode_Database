SELECT
    id,
    name
FROM 
    Students
LEFT OUTER JOIN 
    (SELECT 
        id AS department_id,
        name as department_name
     FROM 
        Departments) AS Temp
ON Students.department_id = Temp.department_id
WHERE department_name IS NULL;
