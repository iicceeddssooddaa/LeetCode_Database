WITH t1 AS (
    SELECT
        machine_id,
        process_id,
        timestamp AS start_time
    FROM
        Activity
    WHERE
        activity_type = "start"
), 
t2 AS (
    SELECT
        machine_id,
        process_id,
        timestamp AS end_time
    FROM
        Activity
    WHERE
        activity_type = "end"
),
temp AS (
    SELECT t1.*, t2.end_time
    FROM t1
    LEFT JOIN t2 ON
        t1.machine_id = t2.machine_id AND
        t1.process_id = t2.process_id
)
SELECT
    machine_id,
    ROUND( (SUM(end_time) - SUM(start_time))/ COUNT(process_id) ,3) AS processing_time
FROM
    temp
GROUP BY
    machine_id
