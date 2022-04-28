WITH tag AS (SELECT DISTINCT query_name FROM Queries),
temp1 AS (
    SELECT
        query_name, COUNT(query_name) AS poor_query_count
    FROM
        Queries
    WHERE
        rating < 3
    GROUP BY query_name   
),
temp2 AS (
SELECT
    query_name, 
    ROUND(SUM(rating/position) / COUNT(query_name), 2) AS quality, 
    COUNT(query_name) AS cnt
FROM
    Queries
GROUP BY query_name
    )
SELECT 
    tag.query_name,
    COALESCE (temp2.quality,0) AS quality,
    ROUND(COALESCE(poor_query_count/cnt * 100, 0), 2) AS poor_query_percentage
FROM tag
LEFT OUTER JOIN temp1 ON tag.query_name = temp1.query_name
LEFT OUTER JOIN temp2 ON tag.query_name = temp2.query_name
