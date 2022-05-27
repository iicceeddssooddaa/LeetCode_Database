WITH c AS (
    SELECT 
        num, frequency, 
        SUM(frequency) OVER (ORDER BY num) AS cum_freq, 
        SUM(frequency) OVER () AS total_cnt
    FROM Numbers
),
t AS (
    SELECT num, cum_freq, COALESCE(LAG(cum_freq) OVER (), 0) AS prev_cum_freq, total_cnt
    FROM c
)
SELECT
    DISTINCT CASE
        WHEN total_cnt %2 != 0 THEN 
            (SELECT MAX(num)
             FROM t
             WHERE prev_cum_freq < (total_cnt + 1)/2 AND (total_cnt + 1)/2 <= cum_freq  )
        ELSE ROUND(((SELECT MAX(num)
             FROM t
             WHERE prev_cum_freq < total_cnt/2 AND total_cnt/2 <= cum_freq) + (SELECT MAX(num)
             FROM t
             WHERE prev_cum_freq < total_cnt/2 + 1 AND total_cnt/2 + 1 <= cum_freq) )/2, 1)
    END AS median
FROM t;
