WITH temp AS ( SELECT DISTINCT id FROM Department ORDER BY id),
    Jan AS ( SELECT id, revenue AS Jan_Revenue
        FROM Department WHERE month = "Jan" ),
    Feb AS ( SELECT id, revenue AS Feb_Revenue
        FROM Department WHERE month = "Feb" ),
    Mar AS ( SELECT id, revenue AS Mar_Revenue
        FROM Department WHERE month = "Mar" ),
    Apr AS ( SELECT id, revenue AS Apr_Revenue
        FROM Department WHERE month = "Apr" ),
    May AS ( SELECT id, revenue AS May_Revenue
        FROM Department WHERE month = "May" ),
    Jun AS ( SELECT id, revenue AS Jun_Revenue
        FROM Department WHERE month = "Jun" ),
    Jul AS ( SELECT id, revenue AS Jul_Revenue
        FROM Department WHERE month = "Jul" ),
    Aug AS ( SELECT id, revenue AS Aug_Revenue
        FROM Department WHERE month = "Aug" ),
    Sep AS ( SELECT id, revenue AS Sep_Revenue
        FROM Department WHERE month = "Sep" ),
    Oct AS ( SELECT id, revenue AS Oct_Revenue
        FROM Department WHERE month = "Oct" ),
    Nov AS ( SELECT id, revenue AS Nov_Revenue
        FROM Department WHERE month = "Nov" ),
    Dec1 AS ( SELECT id, revenue AS Dec_Revenue
        FROM Department WHERE month = "Dec" ),
    temp1 AS ( SELECT temp.*, Jan.Jan_Revenue
        FROM temp LEFT JOIN Jan ON temp.id = Jan.id),
    temp2 AS ( SELECT temp1.*, Feb.Feb_Revenue
        FROM temp1 LEFT JOIN Feb ON temp1.id = Feb.id),
    temp3 AS ( SELECT temp2.*, Mar.Mar_Revenue
        FROM temp2 LEFT JOIN Mar ON temp2.id = Mar.id),
    temp4 AS ( SELECT temp3.*, Apr.Apr_Revenue
        FROM temp3 LEFT JOIN Apr ON temp3.id = Apr.id),
    temp5 AS ( SELECT temp4.*, May.May_Revenue
        FROM temp4 LEFT JOIN May ON temp4.id = May.id),
    temp6 AS ( SELECT temp5.*, Jun.Jun_Revenue
        FROM temp5 LEFT JOIN Jun ON temp5.id = Jun.id),
    temp7 AS ( SELECT temp6.*, Jul.Jul_Revenue
        FROM temp6 LEFT JOIN Jul ON temp6.id = Jul.id),
    temp8 AS ( SELECT temp7.*, Aug.Aug_Revenue
        FROM temp7 LEFT JOIN Aug ON temp7.id = Aug.id),
    temp9 AS ( SELECT temp8.*, Sep.Sep_Revenue
        FROM temp8 LEFT JOIN Sep ON temp8.id = Sep.id),
    temp10 AS ( SELECT temp9.*, Oct.Oct_Revenue
        FROM temp9 LEFT JOIN Oct ON temp9.id = Oct.id),
    temp11 AS ( SELECT temp10.*, Nov.Nov_Revenue
        FROM temp10 LEFT JOIN Nov ON temp10.id = Nov.id),
    temp12 AS ( SELECT temp11.*, Dec1.Dec_Revenue
        FROM temp11 LEFT JOIN Dec1 ON temp11.id = Dec1.id)
SELECT * FROM temp12
