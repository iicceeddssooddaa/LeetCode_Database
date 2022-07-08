WITH t AS (
    SELECT product_id, new_price
    FROM Products
    WHERE (product_id, change_date) IN (SELECT product_id, MAX(change_date) FROM Products WHERE change_date <= '2019-08-16' GROUP BY product_id)
)
SELECT DISTINCT p.product_id, CASE
    WHEN p.product_id NOT IN (SELECT product_id FROM t) THEN 10
    ELSE t.new_price
    END AS price
FROM Products AS p
LEFT OUTER JOIN t ON p.product_id = t.product_id;
