WITH RECURSIVE t1 AS (
    SELECT 
        product_id, period_start, period_end, 
        EXTRACT(YEAR FROM period_start) AS start_year, 
        EXTRACT(YEAR FROM period_end) AS end_year,
        average_daily_sales
    FROM Sales
),
t2(product_id, report_year) AS (
    SELECT product_id, start_year
    FROM t1
    UNION ALL
    SELECT t2.product_id, report_year + 1
    FROM t2
    INNER JOIN t1 ON t2.product_id = t1.product_id
    WHERE report_year < end_year
)

SELECT 
    t2.product_id, product_name, CONVERT(report_year, CHAR) AS report_year,
    average_daily_sales * 
        (CASE
            WHEN start_year = end_year 
            THEN DATEDIFF(period_end,period_start)
            WHEN start_year < report_year AND report_year < end_year 
            THEN DATEDIFF(STR_TO_DATE(CONCAT(report_year,'-12-31'),'%Y-%m-%d'),
                          STR_TO_DATE(CONCAT(report_year,'-01-01'),'%Y-%m-%d'))
            WHEN start_year = report_year 
            THEN DATEDIFF(STR_TO_DATE(CONCAT(report_year,'-12-31'),'%Y-%m-%d'), 
                          period_start)
            ELSE DATEDIFF(period_end, 
                          STR_TO_DATE(CONCAT(report_year,'-01-01'),'%Y-%m-%d'))
        END + 1) AS total_amount
FROM t2
LEFT OUTER JOIN t1 ON t2.product_id = t1.product_id
LEFT OUTER JOIN Product ON t2.product_id = Product.product_id
ORDER BY product_id, report_year
