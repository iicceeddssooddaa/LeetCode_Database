WITH s1 AS (
    SELECT
        product_id,
        "store1" AS store,
        store1 AS price
    FROM
        Products
),
s2 AS (
    SELECT
        product_id,
        "store2" AS store,
        store2 AS price
    FROM
        Products
),
s3 AS (
    SELECT
        product_id,
        "store3" AS store,
        store3 AS price
    FROM
        Products
),
temp AS (
    SELECT * FROM s1
    UNION
    SELECT * FROM s2
    UNION
    SELECT * FROM s3
)
SELECT * FROM temp
WHERE price IS NOT NULL
