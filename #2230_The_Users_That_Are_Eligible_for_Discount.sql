CREATE PROCEDURE getUserIDs(startDate DATE, endDate DATE, minAmount INT)
BEGIN
	# Write your MySQL query statement below.
	WITH temp AS (
        SELECT
            user_id, time_stamp, amount
        FROM
            Purchases
        WHERE
            (time_stamp BETWEEN startDate AND endDate) AND
            (amount >= minAmount)
    )
    SELECT DISTINCT user_id
    FROM temp
    GROUP BY user_id
    ORDER BY user_id;
END
