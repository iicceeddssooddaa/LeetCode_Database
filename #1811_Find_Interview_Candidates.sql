WITH t1 AS (
    SELECT DISTINCT user_id, contest_id - LAG(contest_id,2) OVER (PARTITION BY user_id ORDER BY contest_id) = 2 AS flag
    FROM ((SELECT contest_id, gold_medal AS user_id FROM Contests) 
    UNION ALL 
    (SELECT contest_id, silver_medal AS user_id FROM Contests)
    UNION ALL
    (SELECT contest_id, bronze_medal AS user_id FROM Contests)) t
),
t2 AS (
    (SELECT gold_medal AS user_id FROM Contests GROUP BY gold_medal HAVING COUNT(1) >= 3) 
    UNION 
    (SELECT user_id FROM t1 WHERE t1.flag)
)
SELECT DISTINCT name, mail
FROM t2
LEFT OUTER JOIN Users ON t2.user_id = Users.user_id;
