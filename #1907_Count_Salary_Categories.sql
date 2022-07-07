WITH low AS (
    SELECT
        "Low Salary" AS category,
        COUNT(income) AS accounts_count
    FROM
        Accounts
    WHERE
        income < 20000
),
ave AS (
    SELECT
        "Average Salary" AS category,
        COUNT(income) AS accounts_count
    FROM
        Accounts
    WHERE
        income BETWEEN 20000 AND 50000
),
hi AS (
    SELECT
        "High Salary" AS category,
        COUNT(income) AS accounts_count
    FROM
        Accounts
    WHERE
        income > 50000
)
SELECT * FROM low
UNION
SELECT * FROM ave
UNION
SELECT * FROM hi
