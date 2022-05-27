WITH t AS (
    SELECT 
        CASE
            WHEN from_id > to_id THEN to_id
            ELSE from_id
        END AS person1,
        CASE
            WHEN from_id < to_id THEN to_id
            ELSE from_id
        END AS person2,
        duration
    FROM Calls
)
SELECT 
    DISTINCT person1, person2, COUNT(*) OVER (PARTITION BY person1, person2) AS call_count,
    SUM(duration) OVER (PARTITION BY person1, person2) AS total_duration
FROM t
ORDER BY person1, person2;
