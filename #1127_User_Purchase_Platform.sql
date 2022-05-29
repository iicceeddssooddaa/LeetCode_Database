WITH t1 AS (
    SELECT 
        spend_date, 
        user_id, amount, platform,
        LEAD(platform) OVER (PARTITION BY spend_date, user_id ORDER BY spend_date, user_id) IS NOT NULL AS both_flag1,
        LAG(platform) OVER (PARTITION BY spend_date, user_id ORDER BY spend_date, user_id) IS NOT NULL AS both_flag2
    FROM Spending
),
t2 AS (
    SELECT 
        DISTINCT spend_date, platform, 
        SUM(amount) OVER (PARTITION BY spend_date, platform) AS total_amount,
        COUNT(*) OVER (PARTITION BY spend_date, platform) AS total_users 
    FROM t1
    WHERE NOT (both_flag1 OR both_flag2)
),
t3 AS (
    SELECT
        DISTINCT spend_date, 'both' AS platform, 
        SUM(amount) OVER (PARTITION BY spend_date) AS total_amount,
        SUM(both_flag1) OVER (PARTITION BY spend_date) AS total_users 
    FROM t1
    WHERE both_flag1 OR both_flag2
),
t4 AS (SELECT * FROM t2 UNION SELECT * FROM t3),
t5 AS (SELECT DISTINCT spend_date, p.platform
       FROM Spending, (SELECT 'desktop' AS platform 
                       UNION SELECT 'mobile' AS platform 
                       UNION SELECT 'both' AS platform) AS p)
SELECT 
    t5.spend_date, t5.platform, 
    COALESCE(total_amount,0) AS total_amount, 
    COALESCE(total_users,0) AS total_users
FROM t5
LEFT OUTER JOIN t4 
ON t5.spend_date = t4.spend_date AND t5.platform = t4.platform
