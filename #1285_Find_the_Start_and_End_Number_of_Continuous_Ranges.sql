WITH start_id AS (
    SELECT log_id AS start_id, ROW_NUMBER () OVER () AS row_num
    FROM Logs
    WHERE (log_id - 1 NOT IN (SELECT log_id FROM Logs)) AND (log_id + 1 IN (SELECT log_id FROM Logs))
    ORDER BY start_id
),
end_id AS (
    SELECT log_id AS end_id, ROW_NUMBER () OVER () AS row_num
    FROM Logs
    WHERE (log_id - 1 IN (SELECT log_id FROM Logs)) AND (log_id + 1 NOT IN (SELECT log_id FROM Logs))
    ORDER BY end_id
),
temp AS (
    SELECT start_id, end_id
    FROM start_id
    LEFT OUTER JOIN end_id ON start_id.row_num = end_id.row_num
    UNION
    SELECT log_id AS start_id, log_id AS end_id
    FROM Logs
    WHERE (log_id - 1 NOT IN (SELECT log_id FROM Logs)) AND (log_id + 1 NOT IN (SELECT log_id FROM Logs))
)
SELECT * FROM temp ORDER BY start_id
