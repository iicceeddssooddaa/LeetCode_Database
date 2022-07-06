SELECT DISTINCT session_id
FROM Playback
LEFT OUTER JOIN Ads ON Playback.customer_id = Ads.customer_id AND (timestamp BETWEEN start_time AND end_time)
WHERE timestamp IS NULL;
