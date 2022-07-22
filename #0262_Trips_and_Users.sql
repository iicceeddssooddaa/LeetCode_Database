SELECT DISTINCT request_at AS Day, ROUND(COALESCE(SUM(IF(status = 'completed',0,1)) OVER (PARTITION BY request_at)/COUNT(1) OVER (PARTITION BY request_at),0),2) AS `Cancellation Rate`
FROM Trips
WHERE (request_at BETWEEN '2013-10-01' AND '2013-10-03') AND client_id NOT IN (SELECT users_id FROM Users WHERE banned = 'Yes' AND role = 'client') AND driver_id NOT IN (SELECT users_id FROM Users WHERE banned = 'Yes' AND role = 'driver');
