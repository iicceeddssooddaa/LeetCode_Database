SELECT left_operand, operator, right_operand, IF(CASE
    WHEN operator = '>' THEN v1.value > v2.value
    WHEN operator = '<' THEN v1.value < v2.value
    ELSE v1.value = v2.value
    END, 'true', 'false') AS `value`
FROM Expressions, `Variables` AS v1, `Variables` As v2
WHERE left_operand = v1.name AND right_operand = v2.name;
