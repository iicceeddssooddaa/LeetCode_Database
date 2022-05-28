WITH s1 AS (
    SELECT account_id
        # CASE
        #     WHEN start_date <= '2021-12-31' AND end_date >= '2020-12-31' THEN TRUE
        #     ELSE FALSE
        # END AS sub_flag
    FROM Subscriptions
    WHERE CASE
            WHEN DATEDIFF('2021-12-31',start_date) >= 0 AND DATEDIFF(end_date,'2021-01-01') >= 0 THEN TRUE
            ELSE FALSE
          END
    ORDER BY account_id
),
s2 AS (
    SELECT session_id, account_id
        # CASE
        #     WHEN stream_date BETWEEN '2021-01-01' AND '2021-12-31' THEN TRUE
        #     ELSE FALSE
        # END AS streams_flag
    FROM Streams
    WHERE CASE
            WHEN stream_date BETWEEN '2021-01-01' AND '2021-12-31' THEN TRUE
            ELSE FALSE
          END
    ORDER BY account_id
),
s3 AS (
    SELECT DISTINCT account_id
    FROM s1
    WHERE account_id NOT IN (SELECT account_id FROM s2)
)
SELECT COUNT(*) AS accounts_count FROM s3;
