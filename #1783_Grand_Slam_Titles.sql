WITH t AS (
    SELECT Wimbledon AS player_id FROM Championships
    UNION ALL 
    SELECT Fr_open AS player_id FROM Championships
    UNION ALL
    SELECT US_open AS player_id FROM Championships
    UNION ALL
    SELECT Au_open AS player_id FROM Championships
)
SELECT t.player_id, player_name, COUNT(1) AS grand_slams_count
FROM t
LEFT OUTER JOIN Players ON t.player_id = Players.player_id
GROUP BY t.player_id;
