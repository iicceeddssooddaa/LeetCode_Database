WITH Balance AS
    (SELECT 
        account,
        SUM(amount) as balance
     FROM
        Transactions
     GROUP BY
        account)
SELECT 
    name, 
    balance
FROM
    Users
LEFT OUTER JOIN Balance ON Users.account = Balance.account
WHERE balance > 10000;
