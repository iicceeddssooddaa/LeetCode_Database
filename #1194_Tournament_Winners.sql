WITH t1 AS (
    SELECT DISTINCT first_player AS player_id, SUM(first_score) OVER (PARTITION BY first_player) AS point1
    FROM Matches
),
t2 AS (
    SELECT DISTINCT second_player AS player_id, SUM(second_score) OVER (PARTITION BY second_player) AS point2
    FROM Matches
),
t3 AS (
    SELECT 
        p.player_id, group_id, 
        ROW_NUMBER() OVER (PARTITION BY group_id ORDER BY COALESCE(point1,0) + COALESCE(point2,0) DESC, player_id) AS prank
    FROM Players AS p
    LEFT OUTER JOIN t1 ON p.player_id = t1.player_id
    LEFT OUTER JOIN t2 ON p.player_id = t2.player_id
)
SELECT group_id, player_id
FROM t3
WHERE prank = 1
ORDER BY group_id;
