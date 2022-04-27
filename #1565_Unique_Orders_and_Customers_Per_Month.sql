WITH temp AS (
    SELECT
        DATE_FORMAT(order_date, "%Y-%m") As month,
        customer_id,
        invoice
    FROM
        Orders
    WHERE
        invoice > 20
)
SELECT
    month,
    COUNT(invoice) AS order_count,
    COUNT(DISTINCT customer_id) AS customer_count
FROM temp
GROUP BY month
