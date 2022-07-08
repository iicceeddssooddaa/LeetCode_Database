WITH t AS (
    SELECT pid, tiv_2016, COUNT(1) OVER (PARTITION BY tiv_2015) >1 AS tiv_2015_flag, COUNT(1) OVER (PARTITION BY lat, lon) = 1 AS loc_flag
    FROM Insurance
)
SELECT ROUND(SUM(tiv_2016),2) AS tiv_2016
FROM t
WHERE tiv_2015_flag AND loc_flag;
