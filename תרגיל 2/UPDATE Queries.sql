-- 1. העלאת שכר לעובדים עם פחות מ-10 הזמנות
UPDATE Employee
SET salary = salary * 1.1
WHERE employee_id IN (
  SELECT e.employee_id
  FROM Employee e
  LEFT JOIN Orders o ON e.employee_id = o.employee_id
  GROUP BY e.employee_id
  HAVING COUNT(o.order_id) < 10
);

-- 2. שינוי סטטוס להזמנות ישנות
UPDATE Orders
SET status = 'archived'
WHERE order_date < CURRENT_DATE - INTERVAL '6 months' AND status = 'open';

-- 3. עדכון זמינות טבלאות שלא נוקו
UPDATE Restaurant_Table
SET is_available = 'N'
WHERE last_cleaned < CURRENT_DATE - INTERVAL '7 days';
