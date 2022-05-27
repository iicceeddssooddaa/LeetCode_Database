WITH t AS (
    SELECT followee AS person
    FROM Follow
    WHERE followee IN (SELECT follower FROM Follow)
)
SELECT DISTINCT person AS follower, COUNT(person) OVER (PARTITION BY person) AS num
FROM t
ORDER BY follower;
