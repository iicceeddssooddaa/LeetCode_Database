CREATE FUNCTION getUserIDs(startDate DATE, endDate DATE, minAmount INT) RETURNS INT
BEGIN
  RETURN (
      # Write your MySQL query statement below.
      WITH temp1 AS (
        SELECT
            user_id, time_stamp, amount
        FROM
            Purchases
        WHERE
            (time_stamp BETWEEN startDate AND endDate) AND
            (amount >= minAmount)
    ),
    temp2 AS (
        SELECT DISTINCT user_id
        FROM temp1
        )
    SELECT COUNT(*) FROM temp2
  );
END
