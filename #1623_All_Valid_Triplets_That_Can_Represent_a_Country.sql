SELECT 
    a.student_name AS member_A,
    b.student_name AS member_B,
    c.student_name AS member_C
FROM SchoolA AS a, SchoolB AS b, SchoolC AS c
WHERE
    a.student_name != b.student_name AND
    b.student_name != c.student_name AND
    c.student_name != a.student_name AND
    a.student_id != b.student_id AND
    b.student_id != c.student_id AND
    c.student_id != a.student_id
