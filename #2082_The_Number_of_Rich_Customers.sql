SELECT COUNT(1) AS rich_count FROM (SELECT COUNT(DISTINCT customer_id) AS rich_count
FROM Store
GROUP BY customer_id
HAVING MAX(amount) > 500) AS t;
