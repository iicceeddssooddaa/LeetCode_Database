SELECT DISTINCT user_id
FROM (
    SELECT user_id, DATEDIFF(purchase_date, LAG(purchase_date) OVER (PARTITION BY user_id ORDER BY purchase_date)) <= 7 AS flag
    FROM Purchases
) AS t
WHERE flag;
