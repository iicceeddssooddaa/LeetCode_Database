WITH t AS(
    SELECT
        project_id,
        COUNT(employee_id) AS hd_ct
    FROM
        Project
    GROUP BY
        project_id
    ORDER BY
        hd_ct 
)
SELECT
    project_id
FROM
    t
    JOIN (SELECT MAX(hd_ct) AS max_col
          FROM t) y ON y.max_col = t.hd_ct
