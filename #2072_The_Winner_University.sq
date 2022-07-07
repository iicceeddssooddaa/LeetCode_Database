SELECT CASE
    WHEN (SELECT COUNT(1) FROM NewYork WHERE score >= 90) > (SELECT COUNT(1) FROM California WHERE score >= 90) THEN 'New York University'
    WHEN (SELECT COUNT(1) FROM NewYork WHERE score >= 90) < (SELECT COUNT(1) FROM California WHERE score >= 90) THEN 'California University'
    ELSE 'No Winner'
    END AS winner
