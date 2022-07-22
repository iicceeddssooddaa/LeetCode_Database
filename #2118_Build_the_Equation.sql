SELECT CONCAT(GROUP_CONCAT(
    CASE WHEN factor < 0 THEN CAST(factor AS CHAR) ELSE CONCAT('+',CAST(factor AS CHAR)) END, 
    COALESCE(CASE WHEN power > 1 THEN CONCAT('X^',CAST(power AS CHAR)) WHEN power = 1 THEN 'X' END,'')
              ORDER BY power DESC SEPARATOR ''),'=0') AS equation
FROM Terms;
