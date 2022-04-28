WITH v_ct AS (
    SELECT
        name, COUNT(candidateID) AS vote_cnt
    FROM
        Vote
    LEFT OUTER JOIN Candidate ON Vote.candidateID = Candidate.id
    GROUP BY candidateID
)
SELECT name
FROM v_ct
WHERE vote_cnt = (SELECT MAX(vote_cnt) FROM v_ct)
