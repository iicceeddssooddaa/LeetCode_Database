SELECT email AS EMAIL
FROM Person
GROUP BY email
HAVING COUNT(email) > 1;
