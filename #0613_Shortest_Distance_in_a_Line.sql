WITH t1 AS (
    SELECT x, ROW_NUMBER () OVER () AS code
    FROM Point
),
t2 AS (
    SELECT ABS(p1.x - p2.x) AS dist
    FROM t1 AS p1, t1 AS p2
    WHERE p1.code != p2.code
)
SELECT MIN(dist) AS shortest FROM t2
