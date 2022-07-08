WITH t1 AS (
    SELECT requester_id AS user1_id, accepter_id AS user2_id FROM RequestAccepted
    UNION
    SELECT accepter_id AS user1_id, requester_id AS user2_id FROM RequestAccepted
),
t2 AS (
    SELECT DISTINCT user1_id AS id, COUNT(*) OVER (PARTITION BY user1_id) AS num
    FROM t1
)
SELECT id, num
FROM t2
WHERE num = (SELECT MAX(num) FROM t2);
