WITH v AS (
    SELECT DISTINCT member_id, COUNT(*) OVER (PARTITION BY member_id) AS visit_cnt
    FROM Visits
),
p AS (
    SELECT DISTINCT member_id, COUNT(*) OVER (PARTITION BY member_id) AS purchase_cnt
    FROM Purchases
    LEFT OUTER JOIN Visits ON Purchases.visit_id = Visits.visit_id
),
c AS (
    SELECT v.member_id, 100 * COALESCE(purchase_cnt,0) / visit_cnt AS conv_rate
    FROM v
    LEFT OUTER JOIN p ON v.member_id = p.member_id
)
SELECT 
    Members.member_id, name, 
    CASE
        WHEN conv_rate >= 80 THEN 'Diamond'
        WHEN conv_rate >= 50 AND conv_rate < 80 THEN 'Gold'
        WHEN conv_rate < 50 THEN 'Silver'
        ELSE 'Bronze'
    END AS category
FROM Members
LEFT OUTER JOIN c ON Members.member_id = c.member_id
ORDER BY member_id;
