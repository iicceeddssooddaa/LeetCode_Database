WITH t1 AS (
    SELECT caller_id AS id, duration FROM Calls
    UNION ALL
    SELECT callee_id AS id, duration FROM Calls
),
t2 AS(
    SELECT DISTINCT Country.name, AVG(duration) OVER (PARTITION BY Country.name) AS country_len, AVG(duration) OVER () AS avg_len
    FROM t1
    LEFT OUTER JOIN Person ON t1.id = Person.id
    LEFT OUTER JOIN Country ON LEFT(phone_number,3) = Country.country_code
)
SELECT name AS country
FROM t2
WHERE country_len > avg_len;
