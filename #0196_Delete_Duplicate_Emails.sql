DELETE
    p1
FROM
    Person AS p1
INNER JOIN Person AS p2
WHERE
    p1.id > p2.id AND
    p1.email = p2.email
