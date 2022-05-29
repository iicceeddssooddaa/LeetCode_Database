SELECT left_operand, operator, right_operand,
    IF(CASE
        WHEN operator = '>' THEN v1.value > v2.value
        WHEN operator = '<' THEN v1.value < v2.value
        ELSE v1.value = v2.value
    END, 'true', 'false') AS value
FROM Expressions
LEFT OUTER JOIN `Variables` AS v1 ON Expressions.left_operand = v1.name
LEFT OUTER JOIN `Variables` AS v2 ON Expressions.right_operand = v2.name
