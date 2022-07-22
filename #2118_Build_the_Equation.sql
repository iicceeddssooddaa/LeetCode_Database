SELECT CONCAT(GROUP_CONCAT(
    CONCAT(CASE WHEN factor > 0 THEN '+' ELSE '' END, CAST(factor AS CHAR)), 
    CONCAT(CASE WHEN power > 0 THEN 'X' ELSE '' END, CASE WHEN power > 1 THEN CONCAT('^', CAST(power AS CHAR)) ELSE '' END)
              ORDER BY power DESC SEPARATOR ''),'=0') AS equation
FROM Terms;
