WITH l1 AS (
    SELECT DISTINCT id, login_date FROM Logins ORDER BY id, login_date
),
l2 AS (
    SELECT id, login_date, DATEDIFF(login_date, LAG(login_date, 4) OVER (PARTITION BY id)) AS ddiff
    FROM l1
)
SELECT DISTINCT l2.id, name
FROM l2
LEFT OUTER JOIN Accounts
ON l2.id = Accounts.id
WHERE ddiff = 4;
