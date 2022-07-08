SELECT ROUND(MIN(SQRT( POWER(p1.x - p2.x,2) + POWER(p1.y - p2.y,2))),2) AS shortest
FROM Point2D AS p1
LEFT OUTER JOIN Point2D AS p2 ON NOT (p1.x = p2.x AND p1.y = p2.y);
