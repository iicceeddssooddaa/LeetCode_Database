SELECT DISTINCT sale_date, SUM(IF(fruit = 'apples', sold_num, -sold_num)) OVER (PARTITION BY sale_date) AS diff
FROM Sales
ORDER By sale_date;
