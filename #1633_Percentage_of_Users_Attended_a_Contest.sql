WITH reg AS (
    SELECT
        contest_id,
        COUNT(user_id) AS part
    FROM Register
    GROUP BY contest_id
)
SELECT
    contest_id,
    ROUND(part/(SELECT COUNT(user_id) FROM Users) * 100,2) AS percentage
FROM
    reg
ORDER BY
    percentage DESC,
    contest_id
