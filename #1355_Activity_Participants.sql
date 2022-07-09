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
--------
WITH t AS (
    SELECT DISTINCT Activities.name, COUNT(Friends.name) OVER (PARTITION BY Activities.name) AS cnt
    FROM Activities
    LEFT OUTER JOIN Friends ON Friends.activity = Activities.name
    ORDER BY cnt DESC
)
SELECT name AS activity
FROM t
WHERE cnt != (SELECT cnt FROM t LIMIT 1) AND cnt != (SELECT cnt FROM t ORDER BY cnt LIMIT 1);
