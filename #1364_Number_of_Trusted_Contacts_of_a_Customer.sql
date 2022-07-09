WITH t1 AS (
    SELECT DISTINCT user_id, COUNT(*) OVER (PARTITION BY user_id) AS contacts_cnt
    FROM Contacts
),
t2 AS (
    SELECT DISTINCT user_id, COUNT(*) OVER (PARTITION BY user_id) AS trusted_contacts_cnt
    FROM Contacts
    WHERE contact_name IN (SELECT customer_name FROM Customers)
)
SELECT 
    invoice_id, customer_name, price, 
    COALESCE(contacts_cnt,0) AS contacts_cnt, 
    COALESCE(trusted_contacts_cnt,0) AS trusted_contacts_cnt
FROM Invoices
LEFT OUTER JOIN Customers ON Invoices.user_id = Customers.customer_id
LEFT OUTER JOIN t1 ON Invoices.user_id = t1.user_id
LEFT OUTER JOIN t2 ON INvoices.user_id = t2.user_id
ORDER BY invoice_id;
-----------
WITH t AS (
    SELECT DISTINCT customer_id, customer_name, COUNT(contact_email) OVER (PARTITION BY customer_id) AS contacts_cnt, SUM(IF(contact_email IN (SELECT email FROM Customers),1,0)) OVER (PARTITION BY customer_id) AS trusted_contacts_cnt
    FROM Customers
    LEFT OUTER JOIN Contacts ON Customers.customer_id = Contacts.user_id
)
SELECT invoice_id, customer_name, price, contacts_cnt, trusted_contacts_cnt
FROM Invoices
LEFT OUTER JOIN t ON Invoices.user_id = t.customer_id
ORDER BY invoice_id;
