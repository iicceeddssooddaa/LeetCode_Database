SELECT SUM(IF(DATE_FORMAT(submit_date, '%w')%6, 0,1)) AS weekend_cnt, SUM(IF(DATE_FORMAT(submit_date, '%w')%6, 1,0)) AS working_cnt
FROM Tasks;
