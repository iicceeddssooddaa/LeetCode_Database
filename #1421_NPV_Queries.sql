SELECT
    Queries.*, 
    COALESCE(NPV.npv, 0) AS npv
FROM
    Queries
LEFT JOIN NPV ON
    Queries.id = NPV.id AND
    Queries.year = NPV.year
