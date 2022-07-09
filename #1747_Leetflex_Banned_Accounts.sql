WITH t1 AS (
    SELECT DISTINCT * FROM LogInfo ORDER BY account_id, login
),
t2 AS (
    SELECT account_id, login <= LAG(logout) OVER w AS flag1, ip_address = LAG(ip_address) OVER w AS flag2
    FROM t1
    WINDOW w AS (PARTITION BY account_id ORDER BY login)
)
SELECT DISTINCT account_id
FROM t2
WHERE flag1 AND NOT flag2;
