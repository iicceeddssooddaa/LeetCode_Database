WITH temp AS (
    SELECT
        UnitsSold.product_id,
        units,
        Prices.price,
        units * Prices.price AS total
    FROM
        UnitsSold
    LEFT JOIN Prices ON
        (UnitsSold.product_id = Prices.product_id) AND
        (UnitsSold.purchase_date BETWEEN Prices.start_date AND Prices.end_date)
)

SELECT
    product_id,
    ROUND(SUM(total)/ SUM(units), 2) AS average_price
FROM
    temp
GROUP BY
    product_id
