WITH t1 AS (
    SELECT 
        order_id, item_brand, seller_id, 
        ROW_NUMBER() OVER (PARTITION BY seller_id ORDER BY order_date) AS sell_order
    FROM Orders
    LEFT OUTER JOIN Items ON Orders.item_id = Items.item_id
),
t2 AS (
    SELECT seller_id, item_brand = favorite_brand AS flag
    FROM t1
    LEFT OUTER JOIN Users ON t1.seller_id = Users.user_id
    WHERE sell_order = 2
)
SELECT user_id AS seller_id, 
    CASE
        WHEN user_id in (SELECT seller_id FROM t2 WHERE flag) THEN 'yes'
        ELSE 'no'
    END AS 2nd_item_fav_brand
FROM Users;
