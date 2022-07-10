SELECT t.team_id, name,  
    CAST(RANK() OVER (ORDER BY points DESC, name) AS SIGNED) - 
    CAST(RANK() OVER (ORDER BY (points + points_change) DESC, name) AS SIGNED) AS rank_diff
FROM TeamPoints AS t
LEFT OUTER JOIN PointsChange AS p ON t.team_id = p.team_id;
