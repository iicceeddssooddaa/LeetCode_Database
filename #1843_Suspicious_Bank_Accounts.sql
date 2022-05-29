WITH t1 AS (
    SELECT 
        DISTINCT t.account_id, SUM(amount) OVER (PARTITION BY account_id, DATE_FORMAT(day, '%Y-%m')) > max_income AS flag, DATE_FORMAT(day, '%Y%m') AS month
    FROM Transactions AS t
    LEFT OUTER JOIN Accounts ON t.account_id = Accounts.account_id
    WHERE type = 'Creditor'
),
t2 AS (
    SELECT 
        account_id, 
        flag AND LEAD(flag) OVER (PARTITION BY account_id ORDER BY month) AS cons_flag, 
        PERIOD_DIFF(LEAD(month) OVER (PARTITION BY account_id ORDER BY month), month) AS month_diff
    FROM t1
)
SELECT DISTINCT account_id
FROM t2
WHERE cons_flag AND month_diff = 1
ORDER BY account_id;
