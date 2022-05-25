WITH t1 AS (
    SELECT business_id, event_type, occurences - AVG(occurences) OVER (PARTITION BY event_type) AS dev_act
    FROM Events
    ORDER BY business_id, dev_act DESC
),
t2 AS (
    SELECT DISTINCT business_id, COUNT(dev_act) OVER (PARTITION BY business_id) AS hi_ct
    FROM t1
    WHERE dev_act > 0
)
SELECT business_id
FROM t2
WHERE hi_ct > 1
