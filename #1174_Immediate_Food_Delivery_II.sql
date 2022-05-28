WITH t AS (
    SELECT 
        customer_id, order_date, customer_pref_delivery_date,
        MIN(order_date) OVER (PARTITION BY customer_id) AS first_date,
        CASE
            WHEN order_date = customer_pref_delivery_date THEN TRUE
            ELSE FALSE
        END AS immediate_flag
    FROM Delivery
)
SELECT DISTINCT ROUND(100 * (SELECT COUNT(*) 
                    FROM t 
                    WHERE order_date = first_date AND immediate_flag) / 
                    (SELECT COUNT(*) FROM t WHERE order_date = first_date),2) AS immediate_percentage
FROM t;
#------
#写的不好
