-- 1. מחיקת מנות שלא הוזמנו בכלל
DELETE FROM Dish
WHERE dish_id NOT IN (
  SELECT DISTINCT dish_id FROM Order_Details
);


-- 2. מחיקת מנות יקרות שלא הוזמנו
DELETE FROM Dish
WHERE price > 100 AND dish_id NOT IN (
  SELECT dish_id FROM Order_Details
);

-- 3. מחיקת טבלאות שלא בשימוש
DELETE FROM Restaurant_Table
WHERE table_id NOT IN (
  SELECT table_id FROM Orders
);

--. מחיקת לקוחות שלא הזמינו בשנה האחרונה
--DELETE FROM Customer
--WHERE customer_id NOT IN (
--SELECT customer_id FROM Orders
--WHERE order_date >= CURRENT_DATE - INTERVAL '1 year'
--);