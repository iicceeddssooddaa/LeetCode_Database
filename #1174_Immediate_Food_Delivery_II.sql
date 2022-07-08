WITH t1 AS (
    SELECT 
        customer_id, order_date, customer_pref_delivery_date,
        MIN(order_date) OVER (PARTITION BY customer_id) AS first_date,
        CASE
            WHEN order_date = customer_pref_delivery_date THEN TRUE
            ELSE FALSE
        END AS immediate_flag
    FROM Delivery
),
t2 AS (
    SELECT DISTINCT customer_id, first_date, immediate_flag
    FROM t1
    WHERE order_date = first_date
)
SELECT DISTINCT ROUND(100 * (SELECT COUNT(*) 
                    FROM t2 
                    WHERE immediate_flag) / 
                    (SELECT COUNT(*) FROM t2),2) AS immediate_percentage
FROM t2;
-----------
SELECT ROUND( (SELECT SUM(IF(order_date = customer_pref_delivery_date,1,0)) FROM Delivery WHERE (customer_id, order_date) IN (SELECT customer_id, MIN(order_date) FROM Delivery GROUP BY customer_id))/(SELECT COUNT(DISTINCT customer_id) FROM Delivery) * 100, 2) AS immediate_percentage;
