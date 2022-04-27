WITH t AS(
    SELECT 
        customer_id,
        MAX(amount) AS large
    FROM
        Store
    GROUP BY
        customer_id
)

SELECT
    COUNT(customer_id) AS rich_count
FROM
    t
WHERE large > 500
