WITH w AS (
    SELECT player_id, COALESCE(w_cnt,0) AS w_cnt
    FROM Players
    LEFT OUTER JOIN 
        (SELECT 
            DISTINCT Wimbledon, 
            COUNT(*) OVER (PARTITION BY Wimbledon) AS w_cnt
        FROM Championships) AS c1
        ON Players.player_id = c1.Wimbledon
),
f AS (
    SELECT player_id, COALESCE(f_cnt,0) AS f_cnt
    FROM Players
    LEFT OUTER JOIN 
        (SELECT 
            DISTINCT Fr_open, 
            COUNT(*) OVER (PARTITION BY Fr_open) AS f_cnt
        FROM Championships) AS c2
        ON Players.player_id = c2.Fr_open
),
u AS (
    SELECT player_id, COALESCE(u_cnt,0) AS u_cnt
    FROM Players
    LEFT OUTER JOIN 
        (SELECT 
            DISTINCT US_open, 
            COUNT(*) OVER (PARTITION BY US_open) AS u_cnt
        FROM Championships) AS c3
        ON Players.player_id = c3.US_open
),
a AS (
    SELECT player_id, COALESCE(a_cnt,0) AS a_cnt
    FROM Players
    LEFT OUTER JOIN 
        (SELECT 
            DISTINCT Au_open, 
            COUNT(*) OVER (PARTITION BY Au_open) AS a_cnt
        FROM Championships) AS c4
        ON Players.player_id = c4.Au_open
)
SELECT 
    Players.player_id, Players.player_name, 
    w_cnt + f_cnt + u_cnt + a_cnt AS grand_slams_count
FROM Players
LEFT OUTER JOIN w ON Players.player_id = w.player_id
LEFT OUTER JOIN f ON Players.player_id = f.player_id
LEFT OUTER JOIN u ON Players.player_id = u.player_id
LEFT OUTER JOIN a ON Players.player_id = a.player_id
WHERE w_cnt + f_cnt + u_cnt + a_cnt != 0
ORDER By grand_slams_count;
