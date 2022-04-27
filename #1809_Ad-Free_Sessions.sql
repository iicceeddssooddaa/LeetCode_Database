WITH temp AS (
SELECT 
    Playback.*, Ads.timestamp
FROM
    Playback
LEFT OUTER JOIN Ads ON 
    Playback.customer_id = Ads.customer_id AND
    Ads.timestamp BETWEEN Playback.start_time AND Playback.end_time
)
SELECT session_id
FROM temp
WHERE timestamp IS NULL
