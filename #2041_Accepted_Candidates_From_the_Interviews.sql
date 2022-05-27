WITH r AS (
    SELECT DISTINCT interview_id, SUM(score) OVER (PARTITION BY interview_id) AS total_score
    FROM Rounds
)
SELECT candidate_id
FROM Candidates
LEFT OUTER JOIN r 
ON Candidates.interview_id = r.interview_id
WHERE years_of_exp >= 2 AND total_score > 15
ORDER BY candidate_id;
