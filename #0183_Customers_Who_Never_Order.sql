WITH t AS
    (SELECT Customers.id, Customers.name, Orders.id AS label
     FROM
        Customers
     LEFT OUTER JOIN Orders ON Customers.id = Orders.customerID
     UNION
     SELECT Customers.id, Customers.name, Orders.id AS label
     FROM
        Orders
     LEFT OUTER JOIN Customers ON Customers.id = Orders.customerID
    )
SELECT
    name AS Customers
FROM
    t
WHERE 
    label IS NULL;
