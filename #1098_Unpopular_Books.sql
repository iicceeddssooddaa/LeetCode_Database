WITH t AS (
    SELECT DISTINCT book_id, SUM(quantity) OVER (PARTITION BY book_id) AS total
    FROM Orders
    WHERE DATEDIFF('2019-06-23', dispatch_date) <= 365
)

SELECT Books.book_id, name
FROM Books
LEFT OUTER JOIN t
ON Books.book_id = t.book_id
WHERE DATEDIFF('2019-06-23', available_from) > 31 AND COALESCE(total,0) < 10
