WITH t AS (
    SELECT 
        DISTINCT department_id, DATE_FORMAT(pay_date, '%Y-%m') AS pay_month, 
        AVG(amount) OVER (PARTITION BY DATE_FORMAT(pay_date, '%Y-%m')) AS m_avg,
        AVG(amount) OVER (PARTITION BY department_id, DATE_FORMAT(pay_date, '%Y-%m')) AS d_m_avg
    FROM Salary AS s
    LEFT OUTER JOIN Employee AS e ON s.employee_id = e.employee_id
)
SELECT 
    pay_month, department_id,
    CASE
        WHEN d_m_avg > m_avg THEN 'higher'
        WHEN d_m_avg < m_avg THEN 'lower'
        ELSE 'same'
    END AS comparison
FROM t
ORDER BY department_id, pay_month
