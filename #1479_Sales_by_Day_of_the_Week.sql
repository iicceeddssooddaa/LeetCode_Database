WITH t1 AS (
    SELECT order_id, DATE_FORMAT(order_date, '%W') AS weekday, item_category AS Category, quantity
    FROM Orders
    LEFT OUTER JOIN Items ON Orders.item_id = Items.item_id
),
t2 AS (
    SELECT DISTINCT weekday, Category, SUM(quantity) OVER (PARTITION BY weekday, Category) AS cnt
    FROM t1
),
w1 AS (SELECT Category, cnt AS Monday FROM t2 WHERE weekday = 'Monday'),
w2 AS (SELECT Category, cnt AS Tuesday FROM t2 WHERE weekday = 'Tuesday'),
w3 AS (SELECT Category, cnt AS Wednesday FROM t2 WHERE weekday = 'Wednesday'),
w4 AS (SELECT Category, cnt AS Thursday FROM t2 WHERE weekday = 'Thursday'),
w5 AS (SELECT Category, cnt AS Friday FROM t2 WHERE weekday = 'Friday'),
w6 AS (SELECT Category, cnt AS Saturday FROM t2 WHERE weekday = 'Saturday'),
w7 AS (SELECT Category, cnt AS Sunday FROM t2 WHERE weekday = 'Sunday'),
c AS (SELECT DISTINCT item_category AS Category FROM Items ORDER BY item_category)
SELECT 
    c.Category, 
    COALESCE(Monday,0) AS Monday, 
    COALESCE(Tuesday,0) AS Tuesday, 
    COALESCE(Wednesday,0) AS Wednesday, 
    COALESCE(Thursday,0) AS Thursday, 
    COALESCE(Friday,0) AS Friday, 
    COALESCE(Saturday,0) AS Saturday, 
    COALESCE(Sunday,0) AS Sunday
FROM c
LEFT OUTER JOIN w1 ON c.Category = w1.Category
LEFT OUTER JOIN w2 ON c.Category = w2.Category
LEFT OUTER JOIN w3 ON c.Category = w3.Category
LEFT OUTER JOIN w4 ON c.Category = w4.Category
LEFT OUTER JOIN w5 ON c.Category = w5.Category
LEFT OUTER JOIN w6 ON c.Category = w6.Category
LEFT OUTER JOIN w7 ON c.Category = w7.Category
