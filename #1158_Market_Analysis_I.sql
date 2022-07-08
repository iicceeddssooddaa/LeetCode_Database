WITH o AS (
    SELECT DISTINCT buyer_id, COUNT(*) OVER (PARTITION BY buyer_id) AS orders_in_2019
    FROM Orders 
    WHERE order_date BETWEEN '2019-01-01' AND '2019-12-31'
)
SELECT user_id AS buyer_id, join_date, COALESCE(orders_in_2019,0) AS orders_in_2019
FROM Users
LEFT OUTER JOIN o ON Users.user_id = o.buyer_id
ORDER BY user_id;
---------------
SELECT user_id AS buyer_id, join_date, COALESCE(orders_in_2019,0) AS orders_in_2019
FROM Users
LEFT OUTER JOIN (SELECT buyer_id, COUNT(1) AS orders_in_2019 FROM Orders WHERE order_date BETWEEN '2019-01-01' AND '2019-12-31' GROUP BY buyer_id) t ON Users.user_id = t.buyer_id;
