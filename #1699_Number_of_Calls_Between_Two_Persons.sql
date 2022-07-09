WITH t AS (
    SELECT from_id AS person1, to_id AS person2, duration FROM Calls WHERE from_id < to_id
    UNION ALL
    SELECT to_id AS person1, from_id AS person2, duration FROM Calls WHERE to_id < from_id
)
SELECT person1, person2, COUNT(1) AS call_count, SUM(duration) AS total_duration
FROM t
GROUP BY person1, person2;
