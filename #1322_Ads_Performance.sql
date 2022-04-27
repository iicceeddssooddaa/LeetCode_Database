WITH v AS (
    SELECT
        ad_id,
        COUNT(*) AS click_total
    FROM
        Ads
    WHERE
        action = "Clicked"
    GROUP BY
        ad_id
    ORDER BY
        ad_id
),
t AS (
    SELECT
        ad_id,
        COUNT(*) AS total
    FROM
        Ads
    WHERE
        action = "Viewed" OR action = "Clicked"
    GROUP BY
        ad_id
    ORDER BY
        ad_id
),
temp AS (
    SELECT v.ad_id, v.click_total, t.total
    FROM v
    LEFT OUTER JOIN t ON v.ad_id = t.ad_id
),
s AS(
    SELECT DISTINCT ad_id
    FROM Ads
),
r AS(
SELECT
    ad_id,
    ROUND(click_total/total * 100, 2) AS ctr
FROM temp
ORDER BY ctr DESC, ad_id)
SELECT s.ad_id, COALESCE(ctr, 0) AS ctr
FROM r
RIGHT OUTER JOIN s ON r.ad_id = s.ad_id
ORDER BY ctr DESC, ad_id
