WITH t AS (
    SELECT box_id, b.chest_id, b.apple_count + COALESCE(c.apple_count,0) AS apple_count, b.orange_count + COALESCE(c.orange_count,0) AS orange_count
    FROM Boxes AS b
    LEFT OUTER JOIN Chests AS c
        ON b.chest_id = c.chest_id
)
SELECT (SELECT SUM(apple_count) FROM t) AS apple_count, (SELECT SUM(orange_count) FROM t) AS orange_count
