WITH t AS (
    SELECT score, ROW_NUMBER() OVER () AS 'rank'
    FROM (SELECT DISTINCT score FROM Scores ORDER BY score DESC) AS temp
)
SELECT Scores.score, t.rank
FROM Scores
LEFT OUTER JOIN t ON Scores.score = t.score
ORDER BY score DESC;
