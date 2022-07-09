SELECT account_id, day, SUM(IF(type='Deposit',amount,-amount)) OVER(PARTITION BY account_id ORDER By day) AS balance
FROM Transactions
ORDER BY account_id, day;
