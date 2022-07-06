WITH t AS (
    SELECT parent_id, COUNT(DISTINCT sub_id) AS number_of_comments 
    FROM Submissions 
    WHERE parent_id IS NOT NULL 
    GROUP BY parent_id
)
SELECT DISTINCT sub_id AS post_id, COALESCE(number_of_comments,0) AS number_of_comments
FROM Submissions
LEFT OUTER JOIN t ON Submissions.sub_id = t.parent_id
WHERE sub_id IN (SELECT sub_id FROM Submissions WHERE parent_id IS NULL)
ORDER BY sub_id;
