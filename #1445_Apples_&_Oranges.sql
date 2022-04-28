WITH a_tab AS (
    SELECT
        sale_date, sold_num AS apples
    FROM
        Sales
    WHERE
        fruit = "apples"
),
o_tab AS (
    SELECT
        sale_date, sold_num AS oranges
    FROM
        Sales
    WHERE
        fruit = "oranges"
),
date_tab AS ( SELECT DISTINCT sale_date FROM Sales )
SELECT
    date_tab.sale_date, 
    (COALESCE (a_tab.apples, 0) - COALESCE (o_tab.oranges, 0)) AS diff
FROM
    date_tab
LEFT OUTER JOIN a_tab ON date_tab.sale_date = a_tab.sale_date
LEFT OUTER JOIN o_tab ON date_tab.sale_date = o_tab.sale_date
ORDER BY sale_date
