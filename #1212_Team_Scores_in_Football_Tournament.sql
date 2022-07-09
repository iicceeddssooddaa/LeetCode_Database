WITH t AS (
    (SELECT match_id, host_team AS team_id, CASE WHEN host_goals > guest_goals THEN 3 WHEN host_goals < guest_goals THEN 0 ELSE 1 END AS points 
    FROM Matches)
    UNION ALL
    (SELECT match_id, guest_team AS team_id, CASE WHEN host_goals > guest_goals THEN 0 WHEN host_goals < guest_goals THEN 3 ELSE 1 END AS points
    FROM Matches)
)
SELECT Teams.team_id, team_name, COALESCE(SUM(points),0) AS num_points
FROM Teams
LEFT OUTER JOIN t ON Teams.team_id = t.team_id
GROUP BY team_id
ORDER BY num_points DESC, team_id ASC;
