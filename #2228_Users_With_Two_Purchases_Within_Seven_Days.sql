WITH t AS (
    SELECT purchase_id, user_id,
        DATEDIFF(purchase_date, lag(purchase_date) OVER (PARTITION BY user_id ORDER BY purchase_date)) AS diff
    FROM Purchases
    ORDER BY user_id, purchase_date
)
SELECT DISTINCT user_id
FROM t
WHERE diff <= 7
ORDER BY user_id;
