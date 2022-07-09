WITH t AS (
    SELECT user_id, gender, RANK() OVER (PARTITION BY gender ORDER BY user_id) * 3 - IF(gender = 'female',2,0) - IF(gender = 'other',1,0) AS rnk
    FROM Genders
)
SELECT user_id, gender
FROM t
ORDER BY rnk;
