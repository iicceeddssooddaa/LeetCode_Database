WITH t AS (
    SELECT platform, experiment_name
    FROM ((SELECT 'Android' AS platform) UNION (SELECT 'IOS' AS platform) UNION (SELECT 'Web' AS platform)) AS p, 
    ((SELECT 'Reading' AS experiment_name) UNION (SELECT 'Sports' AS experiment_name) UNION (SELECT 'Programming' AS experiment_name)) AS e
)
SELECT t.platform, t.experiment_name, COALESCE(cnt,0) AS num_experiments
FROM t
LEFT OUTER JOIN (
    SELECT platform, experiment_name, COUNT(experiment_id) AS cnt
    FROM Experiments
    GROUP BY platform, experiment_name
) AS e ON t.platform = e.platform AND t.experiment_name = e.experiment_name;




----------------
select pm platform, name experiment_name, count(experiment_id) num_experiments
from (values('Android'), ('IOS'), ('Web')) p(pm) cross join
(values('Reading'), ('Sports'), ('Programming')) e(name)
left join experiments on p.pm = platform and e.name = experiment_name
group by pm, name
