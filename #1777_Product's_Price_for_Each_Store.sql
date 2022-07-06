SELECT DISTINCT p.product_id, store1, store2, store3
FROM Products AS p
LEFT OUTER JOIN (SELECT product_id, price AS store1 FROM Products WHERE store = 'store1') AS p1 ON p.product_id = p1.product_id
LEFT OUTER JOIN (SELECT product_id, price AS store2 FROM Products WHERE store = 'store2') AS p2 ON p.product_id = p2.product_id
LEFT OUTER JOIN (SELECT product_id, price AS store3 FROM Products WHERE store = 'store3') AS p3 ON p.product_id = p3.product_id
