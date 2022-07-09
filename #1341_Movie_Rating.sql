WITH t1 AS (
    SELECT DISTINCT name AS results
    FROM MovieRating AS m
    LEFT OUTER JOIN Users AS u
    ON m.user_id = u.user_id
    ORDER BY COUNT(*) OVER (PARTITION BY m.user_id) DESC, name
    LIMIT 1
),
t2 AS (
    SELECT DISTINCT title AS results, AVG(rating) OVER (PARTITION BY m.movie_id) AS avgrate
    FROM MovieRating AS m
    LEFT OUTER JOIN Movies AS m1
    ON m.movie_id = m1.movie_id
    WHERE created_at BETWEEN '2020-02-01' AND '2020-02-29'
)
SELECT * FROM t1
UNION
(SELECT results FROM t2
ORDER BY avgrate DESC, results
LIMIT 1)
-------
WITH t1 AS (
    SELECT DISTINCT user_id, COUNT(1) OVER (PARTITION BY user_id) AS cnt
    FROM MovieRating
),
t2 AS (
    SELECT DISTINCT movie_id, AVG(rating) OVER (PARTITION BY movie_id) AS score
    FROM MovieRating
    WHERE created_at BETWEEN '2020-02-01' AND '2020-02-29'
)
(SELECT name AS results FROM Users WHERE user_id IN (SELECT user_id FROM t1 WHERE cnt = (SELECT MAX(cnt) FROM t1))
ORDER BY name LIMIT 1)
UNION
(SELECT title AS results FROM Movies WHERE movie_id IN (SELECT movie_id FROM t2 WHERE score = (SELECT MAX(score) FROM t2))
ORDER BY title LIMIT 1)
