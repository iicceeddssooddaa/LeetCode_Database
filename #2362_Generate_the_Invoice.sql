WITH t1 AS (
    SELECT DISTINCT invoice_id, SUM(price * quantity) OVER (PARTITION BY invoice_id) AS total
    FROM Purchases
    LEFT OUTER JOIN Products ON Purchases.product_id = Products.product_id
    ORDER BY total DESC, invoice_id
    LIMIT 1
)
SELECT Purchases.product_id, quantity, price * quantity AS price
FROM t1
LEFT OUTER JOIN Purchases ON t1.invoice_id = Purchases.invoice_id
LEFT OUTER JOIN Products ON Purchases.product_id = Products.product_id;
