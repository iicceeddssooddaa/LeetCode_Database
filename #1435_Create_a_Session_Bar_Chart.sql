WITH bin1 AS (
    SELECT
        "[0-5>" AS bin, COUNT(duration) AS total
    FROM
        Sessions
    WHERE
        duration < 300
),
bin2 AS (
    SELECT
        "[5-10>" AS bin, COUNT(duration) AS total
    FROM
        Sessions
    WHERE
        duration BETWEEN 300 AND 599
),
bin3 AS (
    SELECT
        "[10-15>" AS bin, COUNT(duration) AS total
    FROM
        Sessions
    WHERE
        duration BETWEEN 600 AND 899
),
bin4 AS (
    SELECT
        "15 or more" AS bin, COUNT(duration) AS total
    FROM
        Sessions
    WHERE
        duration >= 900
)
SELECT * FROM bin1
UNION
SELECT * FROM bin2
UNION
SELECT * FROM bin3
UNION
SELECT * FROM bin4
