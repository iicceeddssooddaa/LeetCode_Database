WITH t AS (
    SELECT 
        username, activity, startDate, endDate,
        RANK() OVER (PARTITION BY username ORDER BY startDate DESC) AS time_order,
        COUNT(*) OVER (PARTITION BY username) AS cnt
    FROM UserActivity
    ORDER BY username, startDate DESC
)
SELECT username, activity, startDate, endDate
FROM t
WHERE 
    CASE
        WHEN cnt = 1 THEN time_order = 1
        ELSE time_order = 2
    END
ORDER BY username;
