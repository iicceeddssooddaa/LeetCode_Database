WITH t1 AS (
    SELECT DISTINCT tiv_2015, COUNT(*) OVER (PARTITION BY tiv_2015) AS prev_inv
    FROM Insurance
),
t2 AS (
    SELECT DISTINCT lat, lon, COUNT(*) OVER (PARTITION BY lat, lon) AS loc_cnt
    FROM Insurance
),
t3 AS (
    SELECT pid
    FROM Insurance
    INNER JOIN t2
    ON Insurance.lat = t2.lat AND Insurance.lon = t2.lon
    WHERE loc_cnt = 1
)
SELECT ROUND(SUM(tiv_2016),2) AS tiv_2016
FROM Insurance
INNER JOIN t1 ON Insurance.tiv_2015 = t1.tiv_2015
INNER JOIN t3 ON Insurance.pid = t3.pid
WHERE prev_inv >=2;
