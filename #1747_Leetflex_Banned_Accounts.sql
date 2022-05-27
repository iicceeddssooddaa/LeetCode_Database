WITH LogInfo_new AS (
    SELECT DISTINCT * FROM LogInfo
    ORDER BY account_id, login
),
t AS (
    SELECT account_id, ip_address, 
        CASE
            WHEN (logout >= lead(login) OVER (PARTITION BY account_id)) AND (ip_address != lead(ip_address) OVER (PARTITION BY account_id)) THEN TRUE
            ELSE FALSE
        END AS flag
    FROM LogInfo_new
)
SELECT DISTINCT account_id
FROM t
WHERE flag
ORDER BY account_id;
