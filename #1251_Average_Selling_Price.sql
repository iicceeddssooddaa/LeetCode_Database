SELECT u.product_id, ROUND(SUM(units * price)/SUM(units),2) AS average_price
FROM UnitsSold AS u
LEFT OUTER JOIN Prices AS p ON u.product_id = p.product_id AND (u.purchase_date BETWEEN p.start_date AND end_date)
GROUP BY product_id;
