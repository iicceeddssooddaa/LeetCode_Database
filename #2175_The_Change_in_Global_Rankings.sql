WITH p1 AS (
    SELECT 
        team_id, name,
        ROW_NUMBER() OVER (ORDER BY points DESC, name) AS old_rank
    FROM TeamPoints
),
p2 AS (
    SELECT
        TeamPoints.team_id, 
        ROW_NUMBER() OVER (ORDER BY points + points_change DESC, name) AS new_rank
    FROM TeamPoints
    LEFT OUTER JOIN PointsChange ON TeamPoints.team_id = PointsChange.team_id
)
SELECT 
    p1.team_id, name, 
    CAST(p1.old_rank AS SIGNED) - CAST(p2.new_rank AS SIGNED) AS rank_diff
FROM p1
LEFT OUTER JOIN p2 
    ON p1.team_id = p2.team_id
ORDER BY p1.team_id;
