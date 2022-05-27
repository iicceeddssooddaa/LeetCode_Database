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
