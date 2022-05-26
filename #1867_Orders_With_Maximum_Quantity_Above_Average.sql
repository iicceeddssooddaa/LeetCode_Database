WITH t1 AS (
    SELECT 
        order_id, 
        AVG(quantity) OVER (PARTITION BY order_id) AS avg_qt, 
        MAX(quantity) OVEr (PARTITION BY order_id) AS max_qt
    FROM OrdersDetails
)
SELECT DISTINCT order_id
FROM t1
WHERE max_qt > (SELECT MAX(avg_qt) FROM t1)
ORDER BY order_id;
