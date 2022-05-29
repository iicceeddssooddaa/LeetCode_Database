WITH t1 AS (
    SELECT id, Country.name
    FROM Person
    LEFT OUTER JOIN Country ON LEFT(Person.phone_number,3) = Country.country_code
),
t2 AS (
    SELECT DISTINCT name, SUM(duration) OVER (PARTITION BY name) AS caller_dur, COUNT(*) OVER(PARTITION BY name) AS caller_cnt
    FROM Calls
    LEFT OUTER JOIN t1 ON Calls.caller_id = t1.id
),
t3 AS (
    SELECT DISTINCT name, SUM(duration) OVER (PARTITION BY name) AS callee_dur, COUNT(*) OVER(PARTITION BY name) AS callee_cnt
    FROM Calls
    LEFT OUTER JOIN t1 ON Calls.callee_id = t1.id
),
t4 AS (
    SELECT Country.name, COALESCE((COALESCE(caller_dur,0) + COALESCE(callee_dur,0)) / (COALESCE(caller_cnt,0) + COALESCE(callee_cnt,0)),0) AS avg_len
    FROM Country
    LEFT OUTER JOIN t2 ON Country.name = t2.name
    LEFT OUTER JOIN t3 ON Country.name = t3.name
)
SELECT name AS country FROM t4
WHERE avg_len > (SELECT AVG(duration)FROM Calls)
ORDER BY name;
