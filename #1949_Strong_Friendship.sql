WITH f AS (
    SELECT * FROM Friendship UNION
    SELECT user2_id AS user1_id, user1_id AS user2_id FROM Friendship
),
f1 AS (
    SELECT f.user1_id, f.user2_id, f2.user2_id AS user3_id
    FROM f
    LEFT OUTER JOIN f AS f2
    ON f.user1_id = f2.user1_id AND f.user2_id != f2.user2_id
),
f3 AS (
    SELECT f1.user1_id, f1.user2_id, f1.user3_id
    FROM f1
    INNER JOIN f
    ON f1.user2_id = f.user1_id AND f1.user3_id = f.user2_id
    WHERE f1.user1_id < f1.user2_id
), 
f4 AS (
SELECT DISTINCT user1_id, user2_id, COUNT(*) OVER (PARTITION BY user1_id, user2_id) AS common_friend
FROM f3
)
SELECT * FROM f4
WHERE common_friend >= 3
ORDER BY user1_id, user2_id;
