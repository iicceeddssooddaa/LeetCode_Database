SELECT first_col, second_col
FROM (SELECT first_col, ROW_NUMBER() OVER (ORDER BY first_col) AS rnk FROM Data) AS t1,
    (SELECT second_col, ROW_NUMBER() OVER (ORDER BY second_col DESC) AS rnk FROM Data) AS t2
WHERE t1.rnk = t2.rnk
ORDER BY t1.rnk;
