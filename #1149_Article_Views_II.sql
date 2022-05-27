WITH t1 AS (
    SELECT DISTINCT * FROM Views
),
t2 AS (
    SELECT viewer_id, COUNT(article_id) OVER (PARTITION BY viewer_id, view_date) AS ct
    FROM t1
)
SELECT DISTINCT viewer_id AS id
FROM t2
WHERE ct > 1
ORDER BY id;
