SELECT person_name
FROM (
    SELECT person_name, turn, SUM(weight) OVER (ORDER BY turn)<=1000 AS flag
    FROM Queue
) AS t
WHERE flag
ORDER BY turn DESC
LIMIT 1;
