WITH t1 AS (
    SELECT 
        DISTINCT platform, experiment_name, 
        COUNT(*) OVER (PARTITION BY platform, experiment_name) AS num_experiments
    FROM Experiments
),
t2 AS (
    SELECT platform, experiment_name
    FROM 
        (SELECT 'Android' AS platform 
         UNION SELECT 'IOS' AS platform 
         UNION SELECT 'Web' AS platform) AS p, 
        (SELECT 'Reading' AS experiment_name 
         UNION SELECT 'Sports' AS experiment_name 
         UNION SELECT 'Programming' AS experiment_name) AS en
)
SELECT t2.platform, t2.experiment_name, COALESCE(num_experiments,0) AS num_experiments
FROM t2
LEFT OUTER JOIN t1
ON t2.platform = t1.platform AND t2.experiment_name = t1.experiment_name
ORDER BY platform, experiment_name;
