WITH t AS (
    SELECT member_id, 100 * (COUNT(charged_amount))/(COUNT(Visits.visit_id)) AS conv_rate
    FROM Visits
    LEFT OUTER JOIN Purchases ON Visits.visit_id = Purchases.visit_id
    GROUP BY member_id
)
SELECT m.member_id, name, CASE
    WHEN conv_rate >=80 THEN 'Diamond'
    WHEN conv_rate BETWEEN 50 AND 80 THEN 'Gold'
    WHEN conv_rate <50 THEN 'Silver'
    ELSE 'Bronze' END AS category
FROM Members AS m
LEFT OUTER JOIN t ON m.member_id = t.member_id;
