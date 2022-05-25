WITH t1 AS (
    SELECT x, y, ROW_NUMBER () OVER () AS code
    FROM Point2D
),
t2 AS (
    SELECT ROUND(SQRT( POWER(p1.x - p2.x, 2) + POWER(p1.y - p2.y,2)),2) AS dist
    FROM t1 AS p1, t1 AS p2
    WHERE p1.code != p2.code
)
SELECT MIN(dist) AS shortest FROM t2
