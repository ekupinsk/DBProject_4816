-- 1. מחיקת לקוחות שנרשמו לפני יותר מ־3 שנים, ושלא ביצעו אף הזמנה.
DELETE FROM Customer
WHERE join_date < CURRENT_DATE - INTERVAL '3 years'
  AND customer_id NOT IN (SELECT customer_id FROM Orders);

--הדפסה
SELECT customer_id, full_name, join_date
FROM Customer
WHERE join_date < CURRENT_DATE - INTERVAL '3 years'
  AND customer_id NOT IN (SELECT customer_id FROM Orders);

-- 2. מחיקת מנות יקרות שלא הוזמנו
DELETE FROM Dish
WHERE price > 100 AND dish_id NOT IN (
  SELECT dish_id FROM Order_Details
);

--הדפסה
SELECT dish_id, name, price FROM Dish
WHERE price > 100 AND dish_id NOT IN (SELECT dish_id FROM Order_Details);

-- 3. מחיקת טבלאות שלא בשימוש
DELETE FROM Restaurant_Table
WHERE table_id NOT IN (
  SELECT table_id FROM Orders
);

SELECT table_id FROM Restaurant_Table
WHERE table_id NOT IN (SELECT table_id FROM Orders);


--. מחיקת לקוחות שלא הזמינו בשנה האחרונה
--DELETE FROM Customer
--WHERE customer_id NOT IN (
--SELECT customer_id FROM Orders
--WHERE order_date >= CURRENT_DATE - INTERVAL '1 year'
--);

-- מחיקת מנות שלא הוזמנו בכלל
--DELETE FROM Dish
--WHERE dish_id NOT IN (
--  SELECT DISTINCT dish_id FROM Order_Details);
