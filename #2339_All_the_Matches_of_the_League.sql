SELECT t1.team_name AS home_team, t2.team_name AS away_team
FROM Teams AS t1, Teams AS t2
WHERE t1.team_name != t2.team_name;
