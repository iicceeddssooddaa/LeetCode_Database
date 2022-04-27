WITH s1 AS (
    SELECT
        product_id,
        price AS store1
    FROM
        Products
    WHERE
        store = "store1"
),
s2 AS (
    SELECT
        product_id,
        price AS store2
    FROM
        Products
    WHERE
        store = "store2"
),
s3 AS (
    SELECT
        product_id,
        price AS store3
    FROM
        Products
    WHERE
        store = "store3"
),
coltab AS (
    SELECT
        DISTINCT product_id
    FROM Products
),
temp1 AS (
    SELECT
        coltab.*, s1.store1
    FROM
        coltab
    LEFT OUTER JOIN s1 ON coltab.product_id = s1.product_id
),
temp2 AS (
    SELECT
        temp1.*, s2.store2
    FROM
        temp1
    LEFT OUTER JOIN s2 ON temp1.product_id = s2.product_id
),
temp3 AS (
    SELECT
        temp2.*, s3.store3
    FROM
        temp2
    LEFT OUTER JOIN s3 ON temp2.product_id = s3.product_id
)
SELECT * FROM temp3
