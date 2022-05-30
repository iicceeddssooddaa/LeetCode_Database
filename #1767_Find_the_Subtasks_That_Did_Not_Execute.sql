WITH RECURSIVE t1(task_id, subtask_id) AS (
    SELECT task_id, 1
    FROM Tasks
     UNION ALL
     SELECT t1.task_id, subtask_id + 1
     FROM t1
     INNER JOIN Tasks ON t1.task_id = Tasks.task_id
     WHERE subtask_id < subtasks_count
)
SELECT task_id, subtask_id
FROM t1
WHERE (task_id, subtask_id) NOT IN (SELECT * FROM Executed)
ORDER BY task_id
