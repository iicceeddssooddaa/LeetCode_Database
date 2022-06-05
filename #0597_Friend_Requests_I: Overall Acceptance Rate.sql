WITH re AS ( SELECT COUNT(*) AS re FROM FriendRequest 
           GROUP BY sender_id, send_to_id),
ac AS ( SELECT COUNT(*) AS ac FROM RequestAccepted
      GROUP BY requester_id, accepter_id),
t1 AS ( SELECT COUNT(*) AS request FROM re ),
t2 AS ( SELECT COUNT(*) AS accept FROM ac )

SELECT 
    ROUND( COALESCE ( (SELECT MAX(accept) FROM t2)/ MAX(request), 0), 2) AS accept_rate
FROM t1
--------------------
SELECT ROUND(COALESCE((SELECT COUNT(DISTINCT requester_id, accepter_id) FROM RequestAccepted) / (SELECT COUNT(DISTINCT sender_id, send_to_id) FROM FriendRequest),0),2) AS accept_rate;
