WITH t1 AS ( SELECT DISTINCT sub_id AS post_id FROM Submissions WHERE parent_id IS NULL),
temp AS (
    SELECT
        sub_id, parent_id
    FROM
        Submissions
    WHERE
        parent_id IN (SELECT * FROM t1)
    GROUP BY
        sub_id, parent_id
    
),
t2 AS (
    SELECT
        parent_id, COUNT(parent_id) AS number_of_comments
    FROM
        temp
    GROUP BY
        parent_id
)
SELECT post_id, COALESCE(number_of_comments,0) AS number_of_comments
FROM t1
LEFT OUTER JOIN t2 ON t1.post_id = t2.parent_id
ORDER BY post_id;
