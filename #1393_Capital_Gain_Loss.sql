# Write your MySQL query statement below
WITH name_tab AS ( SELECT DISTINCT stock_name FROM Stocks ),
buyin AS (
    SELECT
        stock_name, SUM(price) AS cost
    FROM
        Stocks
    WHERE
        operation = "Buy"
    GROUP BY
        stock_name
),
sellout AS (
    SELECT
        stock_name, SUM(price) AS revenue
    FROM
        Stocks
    WHERE
        operation = "Sell"
    GROUP BY
        stock_name
)
SELECT
    name_tab.stock_name, COALESCE(revenue,0) - COALESCE(cost,0) AS capital_gain_loss
FROM
    name_tab
LEFT OUTER JOIN buyin ON name_tab.stock_name = buyin.stock_name
LEFT OUTER JOIN sellout ON name_tab.stock_name = sellout.stock_name
-----------
SELECT DISTINCT stock_name, SUM(IF(operation = 'Sell', price, -price)) OVER (PARTITION BY stock_name) AS capital_gain_loss
FROM Stocks;
