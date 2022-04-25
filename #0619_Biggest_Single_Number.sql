WITH 
    Ct_Tab AS (
        SELECT 
            *, COUNT(num) AS cnt
        FROM
            MyNumbers
        GROUP BY
            num
    )

SELECT MAX(num) AS num
FROM Ct_Tab
WHERE cnt = 1;
