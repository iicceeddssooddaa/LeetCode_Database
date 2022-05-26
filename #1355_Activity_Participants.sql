WITH t1 AS (
    SELECT activity, COUNT(*) AS freq FROM Friends GROUP BY activity
),
t2 AS (
    SELECT activity, freq, MAX(freq) OVER () AS max_act, MIN(freq) OVER () AS min_act
    FROM t1
)
SELECT activity
FROM t2
LEFT OUTER JOIN Activities
ON Activities.name = t2.activity
WHERE freq != max_act AND freq != min_act
ORDER BY activity;
