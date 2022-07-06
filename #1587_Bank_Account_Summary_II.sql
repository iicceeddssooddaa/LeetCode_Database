SELECT name, SUM(amount) AS balance
FROM Transactions
LEFT OUTER JOIN Users ON Transactions.account = Users.account
GROUP BY Transactions.account
HAVING SUM(amount) > 10000;
