SELECT DISTINCT s.user_id, ROUND( COALESCE(SUM(IF(action = 'confirmed',1,0)) OVER w/ COUNT(1) OVER w,0), 2) AS confirmation_rate
FROM Confirmations AS c
RIGHT OUTER JOIN Signups AS s ON c.user_id = s.user_id
WINDOW w AS (PARTITION BY c.user_id);
