WITH t1 AS (
    SELECT DISTINCT post_id, extra AS report_reason
    FROM Actions
    WHERE action_date = '2019-07-04' AND action = 'report'
)
SELECT DISTINCT report_reason, COUNT(post_id) OVER (PARTITION BY report_reason) AS report_count
FROM t1
