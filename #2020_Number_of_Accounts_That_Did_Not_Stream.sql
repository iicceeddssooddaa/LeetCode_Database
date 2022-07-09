SELECT COUNT(DISTINCT account_id) AS accounts_count
FROM Subscriptions 
WHERE NOT(DATEDIFF('2021-01-01',end_date)>0 OR DATEDIFF(start_date,'2021-12-31')>0) AND (account_id NOT IN (SELECT account_id 
FROM Streams 
WHERE stream_date BETWEEN '2021-01-01' AND '2021-12-31'));
