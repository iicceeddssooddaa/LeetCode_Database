WITH f1 AS (
    SELECT fail_date, "failed" AS period_state FROM Failed
    WHERE fail_date BETWEEN '2019-01-01' AND '2019-12-31'
    ORDER BY fail_date
),
f3 AS (
    SELECT fail_date AS start_date, period_state, ROW_NUMBER() OVER () AS row_num
    FROM f1
    WHERE (ADDDATE(fail_date,-1) NOT IN (SELECT fail_date FROM f1)) 
        AND (ADDDATE(fail_date,1) IN (SELECT fail_date FROM f1))
),
f4 AS (
    SELECT fail_date AS end_date, period_state, ROW_NUMBER() OVER () AS row_num
    FROM f1
    WHERE (ADDDATE(fail_date,-1) IN (SELECT fail_date FROM f1)) 
        AND (ADDDATE(fail_date,1) NOT IN (SELECT fail_date FROM f1))
),
s1 AS (
    SELECT success_date, "succeeded" AS period_state FROM Succeeded
    WHERE success_date BETWEEN '2019-01-01' AND '2019-12-31'
),
s3 AS (
    SELECT success_date AS start_date, period_state, ROW_NUMBER() OVER () AS row_num
    FROM s1
    WHERE (ADDDATE(success_date, -1) NOT IN (SELECT success_date FROM s1)) 
        AND (ADDDATE(success_date, 1) IN (SELECT success_date FROM s1))
),
s4 AS (
    SELECT success_date AS end_date, period_state, ROW_NUMBER() OVER () AS row_num
    FROM s1
    WHERE (ADDDATE(success_date, -1) IN (SELECT success_date FROM s1)) 
        AND (ADDDATE(success_date, 1) NOT IN (SELECT success_date FROM s1))
)

SELECT period_state, start_date, end_date
FROM (SELECT * FROM (
            SELECT fail_date AS start_date, fail_date AS end_date, period_state
            FROM f1
            WHERE (ADDDATE(fail_date,-1) NOT IN (SELECT fail_date FROM f1)) 
                AND (ADDDATE(fail_date,1) NOT IN (SELECT fail_date FROM f1))) AS f2
        UNION
        SELECT * FROM (
            SELECT start_date, end_date, f3.period_state
            FROM f3
            LEFT OUTER JOIN f4 ON f3.row_num = f4.row_num
        ) AS f5
        UNION
        SELECT * FROM (
            SELECT success_date AS start_date, success_date AS end_date, period_state
            FROM s1
            WHERE (ADDDATE(success_date, -1) NOT IN (SELECT success_date FROM s1)) 
                AND (ADDDATE(success_date, 1) NOT IN (SELECT success_date FROM s1))) AS s2
        UNION
        SELECT * FROM (
            SELECT start_date, end_date, s3.period_state
            FROM s3
            LEFT OUTER JOIN s4 ON s3.row_num = s4.row_num
        )AS s5) AS t
ORDER BY start_date
