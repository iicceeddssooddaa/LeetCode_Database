WITH t2 AS (
    SELECT DISTINCT user1_id, user2_id, COUNT(follower_id) OVER (PARTITION BY user1_id, user2_id) AS common_cnt
    FROM 
    (SELECT r1.user_id AS user1_id, r2.user_id AS user2_id, r1.follower_id
    FROM Relations AS r1
    LEFT OUTER JOIN Relations AS r2 ON r1.follower_id = r2.follower_id AND r1.user_id != r2.user_id) AS
    t1
    WHERE user1_id < user2_id
),
t3 AS (
    SELECT MAX(common_cnt) FROM t2
)
SELECT user1_id, user2_id
FROM t2
WHERE common_cnt IN (SELECT * FROM t3)
ORDER BY user1_id, user2_id;
