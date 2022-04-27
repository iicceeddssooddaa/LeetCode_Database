WITH t AS
    (SELECT
        COUNT(transaction_id) AS trans_cnt,
        visit_id
    FROM
        Transactions
    GROUP BY 
        visit_id)

SELECT 
    customer_id, 
    COUNT(Visits.visit_id) - COUNT(trans_cnt) AS count_no_trans
FROM
    Visits
LEFT OUTER JOIN t ON Visits.visit_id = t.visit_id
WHERE trans_cnt IS NULL
GROUP BY customer_id
