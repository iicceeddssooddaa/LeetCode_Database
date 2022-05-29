WITH RECURSIVE t1 AS (
    SELECT DISTINCT user_id, transaction_date, COUNT(*) OVER (PARTITION BY user_id, transaction_date) AS trans_cnt
    FROM Transactions
),
t2 AS (SELECT 0 AS transactions_count
    UNION ALL
    SELECT transactions_count + 1
    FROM t2
    WHERE transactions_count < (SELECT MAX(trans_cnt) FROM t1)
),
t3 AS (
    SELECT 0 AS transactions_count, COUNT(*) AS visits_count
    FROM Visits
    LEFT OUTER JOIN Transactions
    ON Visits.user_id = Transactions.user_id AND Visits.visit_date = Transactions.transaction_date
    WHERE amount IS NULL
),
t4 AS (
    SELECT trans_cnt AS transactions_count, COUNT(*) OVER (PARTITION BY trans_cnt) AS visits_count
    FROM t1
),
t5 AS (
    SELECT * FROM t3 UNION SELECT * FROM t4
)
SELECT t2.transactions_count, COALESCE(visits_count,0) AS visits_count
FROM t2
LEFT OUTER JOIN t5 ON t2.transactions_count = t5.transactions_count
ORDER BY transactions_count;
