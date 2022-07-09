WITH t1 AS (
    SELECT user1_id AS user_id FROM Friendship WHERE user2_id = 1
    UNION
    SELECT user2_id AS user_id FROM Friendship WHERE user1_id = 1
),
t2 AS (
    SELECT page_id FROM Likes WHERE user_id = 1
)
SELECT DISTINCT page_id AS recommended_page
FROM Likes
WHERE user_id IN (SELECT * FROM t1) AND (page_id NOT IN (SELECT * FROM t2));
--------
SELECT DISTINCT page_id AS recommended_page
FROM Likes
WHERE (page_id NOT IN (SELECT page_id FROM Likes WHERE user_id = 1))
    AND user_id IN ((SELECT user2_id AS user_id FROM Friendship WHERE user1_id = 1) UNION (SELECT user1_id AS user_id FROM Friendship WHERE user2_id = 1));
