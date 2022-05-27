SELECT id, 
    CASE
        WHEN (id %2 !=0 AND id < (SELECT MAX(id) FROM Seat)) THEN lead(student) OVER ()
        WHEN id %2 =0 THEN lag(student) OVER()
        ELSE student
    END AS student
FROM Seat
ORDER BY id;
