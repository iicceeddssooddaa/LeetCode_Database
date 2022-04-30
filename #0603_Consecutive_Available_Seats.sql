WITH t1 AS (
    SELECT
        c1.seat_id, c1.free, c2.free AS next_free, c3.free AS previous_free
    FROM
        Cinema AS c1
    LEFT OUTER JOIN Cinema AS c2 ON c1.seat_id + 1 = c2.seat_id
    LEFT OUTER JOIN Cinema AS c3 ON c1.seat_id - 1 = c3.seat_id
),
t4 AS (
    SELECT * FROM (
    SELECT
        seat_id
    FROM t1
    WHERE
        free = 1 AND next_free = 1
) AS t2
    UNION
    SELECT * FROM (
    SELECT
        seat_id
    FROM t1
    WHERE
        free = 1 AND previous_free = 1
) AS t3
)
SELECT DISTINCT seat_id
FROM t4
ORDER BY seat_id
