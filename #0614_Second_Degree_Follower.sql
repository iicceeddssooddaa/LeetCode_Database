SELECT DISTINCT followee AS follower, COUNT(1) OVER (PARTITION BY followee) AS num
FROM Follow
WHERE followee IN (SELECT DISTINCT follower FROM Follow)
ORDER BY follower;
