SELECT id, 
    CASE
        WHEN (id %2 !=0 AND id < (SELECT MAX(id) FROM Seat)) THEN lead(student) OVER ()
        WHEN id %2 =0 THEN lag(student) OVER()
        ELSE student
    END AS student
FROM Seat
ORDER BY id;
--------
SELECT id, CASE
    WHEN NOT (id%2) THEN LAG(student) OVER (ORDER BY id)
    WHEN (LEAD(id) OVER (ORDER BY id) IS NOT NULL) THEN LEAD (student) OVER (ORDER BY id)
    ELSE student
    END AS student
FROM Seat
ORDER BY id;
