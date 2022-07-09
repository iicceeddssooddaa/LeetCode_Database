WITH t AS (
    (SELECT home_team_id AS team_id, CASE 
        WHEN home_team_goals > away_team_goals THEN 3
        WHEN home_team_goals < away_team_goals THEN 0
        ELSE 1 END AS points, home_team_goals AS goal_for, away_team_goals AS goal_against
    FROM Matches)
    UNION ALL
    (SELECT away_team_id AS team_id, CASE 
        WHEN home_team_goals > away_team_goals THEN 0
        WHEN home_team_goals < away_team_goals THEN 3
        ELSE 1 END AS points, away_team_goals AS goal_for, home_team_goals AS goal_against
    FROM Matches)
)
SELECT team_name, COUNT(t.team_id) AS matches_played, COALESCE(SUM(points),0) AS points,
    COALESCE(SUM(goal_for),0) AS goal_for,
    COALESCE(SUM(goal_against),0) AS goal_against,
    COALESCE(SUM(goal_for),0) - COALESCE(SUM(goal_against),0) AS goal_diff
FROM Teams
RIGHT OUTER JOIN t ON Teams.team_id = t.team_id
GROUP BY Teams.team_id
ORDER BY points DESC, goal_diff DESC, team_name;
