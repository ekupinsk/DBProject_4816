-- SELECT Queries
-- 1. לקוחות שהזמינו בחודש אפריל
SELECT c.full_name, c.email, COUNT(*) AS orders_count
FROM Customer c
JOIN Orders o ON c.customer_id = o.customer_id
WHERE EXTRACT(MONTH FROM o.order_date) = 4
GROUP BY c.customer_id, c.full_name, c.email
ORDER BY orders_count DESC;

-- 2. סכום הכנסות כל מלצר לפי שנה
SELECT e.name, EXTRACT(YEAR FROM o.order_date) AS year, SUM(o.total_amount) AS income
FROM Employee e
JOIN Orders o ON e.employee_id = o.employee_id
GROUP BY e.name, year
ORDER BY income DESC;

-- 3. ממוצע כמות מנה בהזמנות עם קטגוריה מסוימת
SELECT d.category, AVG(od.quantity) AS avg_quantity
FROM Order_Details od
JOIN Dish d ON od.dish_id = d.dish_id
GROUP BY d.category
ORDER BY avg_quantity DESC;

-- 4. טבלאות שלא נוקו יותר מ-7 ימים
SELECT table_id, seats, last_cleaned
FROM Restaurant_Table
WHERE last_cleaned < CURRENT_DATE - INTERVAL '7 days';

-- 5. מנות טבעוניות שלא הוזמנו כלל
SELECT d.name, d.category
FROM Dish d
LEFT JOIN Order_Details od ON d.dish_id = od.dish_id
WHERE od.order_id IS NULL AND d.is_vegan = 'Y';

-- 6. הזמנות שבוצעו ביום ראשון
SELECT o.order_id, c.full_name, o.order_date
FROM Orders o
JOIN Customer c ON o.customer_id = c.customer_id
WHERE EXTRACT(DOW FROM o.order_date) = 0;

-- 7. לקוחות שהוציאו מעל 50 שח
SELECT c.full_name, SUM(o.total_amount) AS total_spent
FROM Customer c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.full_name
HAVING SUM(o.total_amount) > 50;

-- 8. הזמנות אחרונות שבוצעו על ידי כל לקוח
SELECT c.full_name, o.order_id, o.order_date, o.total_amount
FROM Orders o
JOIN Customer c ON o.customer_id = c.customer_id
WHERE o.order_date = (
  SELECT MAX(o2.order_date)
  FROM Orders o2
  WHERE o2.customer_id = c.customer_id
);