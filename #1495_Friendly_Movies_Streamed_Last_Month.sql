WITH t1 AS (
    SELECT
        program_date, content_id
    FROM
        TVProgram
    WHERE
        program_date BETWEEN "2020-06-01" AND "2020-06-30"
)
SELECT
    DISTINCT title
FROM
    t1
LEFT OUTER JOIN Content ON t1.content_id = Content.content_id
WHERE 
    (Kids_content = "Y") AND (content_type = "Movies")
