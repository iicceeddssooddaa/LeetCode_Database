SELECT SUM(b.apple_count + COALESCE(c.apple_count,0)) AS apple_count, SUM(b.orange_count + COALESCE(c.orange_count,0)) AS orange_count
FROM Boxes AS b
LEFT OUTER JOIN Chests AS c ON b.chest_id = c.chest_id;
