WITH h AS (
    SELECT 
        DISTINCT home_team_id AS team_id, 
        SUM(home_team_goals) OVER (PARTITION BY home_team_id) AS goals1, 
        SUM(away_team_goals) OVER (PARTITION BY home_team_id) AS goals2,
        SUM(CASE
            WHEN home_team_goals > away_team_goals THEN 3
            WHEN home_team_goals < away_team_goals THEN 0
            ELSE 1
        END) OVER (PARTITION BY home_team_id) AS point1,
        COUNT(*) OVER (PARTITION BY home_team_id) AS h_matches
    FROM Matches
),
a AS (
    SELECT 
        DISTINCT away_team_id AS team_id, 
        SUM(away_team_goals) OVER (PARTITION BY away_team_id) AS goals3, 
        SUM(home_team_goals) OVER (PARTITION BY away_team_id) AS goals4, 
        SUM(CASE
            WHEN home_team_goals > away_team_goals THEN 0
            WHEN home_team_goals < away_team_goals THEN 3
            ELSE 1
        END) OVER (PARTITION BY away_team_id) AS point2,
        COUNT(*) OVER (PARTITION BY away_team_id) AS a_matches
    FROM Matches
)
SELECT 
    team_name, 
    COALESCE(h_matches,0) + COALESCE(a_matches,0) AS matches_played,
    COALESCE(point1,0) + COALESCE(point2,0) AS points,
    COALESCE(goals1,0) + COALESCE(goals3,0) AS goal_for,
    COALESCE(goals2,0) + COALESCE(goals4,0) AS goal_against,
    (COALESCE(goals1,0) + COALESCE(goals3,0)) - (COALESCE(goals2,0) + COALESCE(goals4,0)) AS goal_diff
FROM Teams
LEFT OUTER JOIN h ON Teams.team_id = h.team_id
LEFT OUTER JOIN a ON Teams.team_id = a.team_id
WHERE COALESCE(h_matches,0) + COALESCE(a_matches,0) != 0
ORDER BY points DESC, goal_diff DESC, team_name;
