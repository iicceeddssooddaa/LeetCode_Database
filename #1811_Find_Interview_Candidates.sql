WITH t1 AS (
    SELECT contest_id, gold_medal AS user_id FROM Contests
    UNION
    SELECT contest_id, silver_medal AS user_id FROM Contests
    UNION
    SELECT contest_id, bronze_medal AS user_id FROM Contests
),
t2 AS (
    SELECT DISTINCT gold_medal AS user_id, COUNT(*) OVER (PARTITION BY gold_medal) AS gold_cnt
    FROM Contests
),
t3 AS (
    SELECT user_id, contest_id - LAG(contest_id,2) OVER (PARTITION BY user_id ORDER BY contest_id) AS flag
    FROM t1
),
t4 AS (
    (SELECT DISTINCT user_id
    FROM t3
    WHERE flag = 2)
    UNION
    (SELECT DISTINCT user_id
    FROM t2
    WHERE gold_cnt >= 3)
)
SELECT DISTINCT name, mail
FROM Users
INNER JOIN t4 ON Users.user_id = t4.user_id
ORDER BY name;
