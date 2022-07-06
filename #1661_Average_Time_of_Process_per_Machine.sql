SELECT machine_id, ROUND(SUM(IF(activity_type='end',timestamp,-timestamp))/SUM(IF(activity_type='start',1,0)),3) AS processing_time
FROM Activity
GROUP BY machine_id;
