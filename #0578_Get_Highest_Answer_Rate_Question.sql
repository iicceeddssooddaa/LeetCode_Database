WITH s1 AS (
    SELECT DISTINCT question_id, COUNT(action) OVER (PARTITION BY question_id) AS show_cnt
    FROM SurveyLog
    WHERE action = 'show'
),
s2 AS (
    SELECT DISTINCT question_id, COUNT(action) OVER (PARTITION BY question_id) AS answer_cnt
    FROM t
    WHERE action = 'answer'
),
r AS (
    SELECT s1.question_id, COALESCE(answer_cnt/(answer_cnt + show_cnt),0) AS answer_rate
    FROM s1
    LEFT OUTER JOIN s2 ON s1.question_id = s2.question_id
    ORDER BY answer_rate DESC, s1.question_id
)
SELECT question_id AS survey_log
FROM r
LIMIT 1;
--------
WITH t AS (
    SELECT DISTINCT question_id, 
        SUM(IF(action='answer', 1, 0)) OVER (PARTITION BY question_id) / 
        SUM(IF(action='show', 1, 0)) OVER (PARTITION BY question_id) AS ans_rate
    FROM SurveyLog
)
SELECT question_id AS survey_log
FROM t
ORDER BY ans_rate DESC, question_id
LIMIT 1;
