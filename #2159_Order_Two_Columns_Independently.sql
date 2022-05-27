WITH t1 AS (
    SELECT first_col, ROW_NUMBER() OVER (ORDER BY first_col) AS fir_rank
    FROM Data
),
t2 AS (
    SELECT second_col, ROW_NUMBER() OVER (ORDER BY second_col DESC) AS sec_rank
    FROM Data
)
SELECT first_col, second_col
FROM t1
LEFT OUTER JOIN t2
ON t1.fir_rank = t2.sec_rank;
