# שלב ב – שאילתות ואילוצים




בשלב זה ביצענו שאילתות מורכבות לבסיס הנתונים שנבנה בשלב א, כולל פעולות SELECT, מחיקות, עדכונים, אילוצים, ושימוש בפקודות ROLLBACK ו-COMMIT. מטרת השלב היא לתרגל שליפה ותחזוקה של נתונים בצורה מקצועית, תוך שמירה על שלמות הנתונים וקישוריות נכונה בין הטבלאות.
---

## ✫️ חלק 1: אילוצים (Constraints)

### ✅ אילוץ 1 – NOT NULL על שם לקוח

```sql
ALTER TABLE Customer
ALTER COLUMN full_name SET NOT NULL;
```

![אילוץ NOT NULL](https://github.com/user-attachments/assets/a4a60f43-a7a4-49fc-b49a-f8335e43c5d3)


---

### ✅ אילוץ 2 – CHECK על מחיר מנה

```sql
ALTER TABLE Dish DROP CONSTRAINT IF EXISTS chk_price_positive;
ALTER TABLE Dish ADD CONSTRAINT chk_price_positive CHECK (price >= 0);
```
![אילוץ CHECK](https://github.com/user-attachments/assets/d5c3b827-f205-46cd-b57c-29c506f1aaf2)


---

### ✅ אילוץ 3 – DEFAULT לזמינות שולחן

```sql
ALTER TABLE Restaurant_Table
ALTER COLUMN is_available SET DEFAULT 'Y';
```

![אילוץ DEFAULT](https://github.com/user-attachments/assets/d0c3d751-8e99-410f-9a60-73daa37f6497)


---

## 🗑️ חלק 2: שאילתות מחיקה (DELETE)

### ❌ מחיקת מנות שלא הוזמנו כלל

```sql
DELETE FROM Dish
WHERE dish_id NOT IN (
  SELECT DISTINCT dish_id FROM Order_Details
);
```

![מחיקת מנות שלא הוזמנו בכלל](https://github.com/user-attachments/assets/4c2365f8-f6a6-4291-bf67-341c1f9e1af8)


---

### ❌ מחיקת מנות יקרות שלא הוזמנו

```sql
DELETE FROM Dish
WHERE price > 100 AND dish_id NOT IN (
  SELECT dish_id FROM Order_Details
);
```

![מחיקת מנות יקרות שלא הוזמנו](https://github.com/user-attachments/assets/4665d918-b815-4b99-9483-b3b1436b0029)


---

### ❌ מחיקת שולחנות שלא היו בשימוש

```sql
DELETE FROM Restaurant_Table
WHERE table_id NOT IN (
  SELECT table_id FROM Orders
);
```

![מחיקת שולחנות שלא בשימוש](https://github.com/user-attachments/assets/0f0896d6-45dc-489e-a7e1-6ac7bd5a77bf)


---

## 🔍 חלק 3: שאילתות SELECT

### ✅ שאילתא 1 – לקוחות שהזמינו באפריל

```sql
SELECT c.full_name, c.email, COUNT(*) AS orders_count
FROM Customer c
JOIN Orders o ON c.customer_id = o.customer_id
WHERE EXTRACT(MONTH FROM o.order_date) = 4
GROUP BY c.customer_id, c.full_name, c.email
ORDER BY orders_count DESC;
```


![לקוחות שהזמינו בחודש אפריל](https://github.com/user-attachments/assets/c7e7e5ce-6208-4267-ad30-8f5fb334c2c1)

---

### ✅ שאילתא 2 – כל מלצר לפי שנה

```sql
SELECT e.name, EXTRACT(YEAR FROM o.order_date) AS year, SUM(o.total_amount) AS income
FROM Employee e
JOIN Orders o ON e.employee_id = o.employee_id
GROUP BY e.name, year
ORDER BY income DESC;
```

![סכום הכנסות כל מלצר לפי שנה](https://github.com/user-attachments/assets/312f97a2-88ef-4fc6-b5cf-2859baf2e8d8)


---

### ✅ שאילתא 3 – ממוצע כמות לפי קטגוריה

```sql
SELECT d.category, AVG(od.quantity) AS avg_quantity
FROM Order_Details od
JOIN Dish d ON od.dish_id = d.dish_id
GROUP BY d.category
ORDER BY avg_quantity DESC;
```

![ממוצע כמות מנה בהזמנות עם קטגוריה מסוימת](https://github.com/user-attachments/assets/547c4a0c-8b29-496f-ae17-2a419dcf0539)


---

### ✅ שאילתא 4 – שולחנות שלא נוקו בשבוע אחרון

```sql
SELECT table_id, seats, last_cleaned
FROM Restaurant_Table
WHERE last_cleaned < CURRENT_DATE - INTERVAL '7 days';
```

![טבלאות שלא נוקו יותר מ-7 ימים](https://github.com/user-attachments/assets/015b65a0-bdae-4194-a617-78862db9de69)


---

### ✅ שאילתא 5 – מנות טבעוניות שלא הוזמנו

```sql
SELECT d.name, d.category
FROM Dish d
LEFT JOIN Order_Details od ON d.dish_id = od.dish_id
WHERE od.order_id IS NULL AND d.is_vegan = 'Y';
```

![מנות טבעוניות שלא הוזמנו כלל](https://github.com/user-attachments/assets/4c254ec9-8e4e-46be-8394-6a58074cdaf7)


---

### ✅ שאילתא 6 – הזמנות ביום ראשון

```sql
SELECT o.order_id, c.full_name, o.order_date
FROM Orders o
JOIN Customer c ON o.customer_id = c.customer_id
WHERE EXTRACT(DOW FROM o.order_date) = 0;
```

![הזמנות שבוצעו ביום ראשון](https://github.com/user-attachments/assets/91119373-8d64-4f53-ac28-5695b74d540a)


---

### ✅ שאילתא 7 – לקוחות שהוציאו מעל 50 ש"ח

```sql
SELECT c.full_name, SUM(o.total_amount) AS total_spent
FROM Customer c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.full_name
HAVING SUM(o.total_amount) > 50;
```

![לקוחות שהוציאו מעל 50 שח](https://github.com/user-attachments/assets/d1af2c4f-083a-403a-824b-02ef9e3245e1)


---

### ✅ שאילתא 8 – הזמנה אחרונה של כל לקוח

```sql
SELECT c.full_name, o.order_id, o.order_date, o.total_amount
FROM Orders o
JOIN Customer c ON o.customer_id = c.customer_id
WHERE o.order_date = (
  SELECT MAX(o2.order_date)
  FROM Orders o2
  WHERE o2.customer_id = c.customer_id
);
```

![הזמנות אחרונות שבוצעו על ידי כל לקוח](https://github.com/user-attachments/assets/095601f8-f821-474f-b191-60a44643571c)


---

## 🔁 חלק 4: שימוש ב‏ROLLBACK ו‏COMMIT

### ↺ עדכון זמני עם ROLLBACK

```sql
BEGIN;
UPDATE Dish SET price = price * 1.2;
SELECT * FROM Dish;
ROLLBACK;
SELECT * FROM Dish;
```

![עדכון זמני עם ROLLBACK](https://github.com/user-attachments/assets/5b70355b-4708-48f3-b0cd-fd9ff40bd075)


---

### ✅ עדכון קבוע עם COMMIT

```sql
BEGIN;
UPDATE Dish SET price = price * 0.9;
SELECT * FROM Dish;
COMMIT;
SELECT * FROM Dish;
```

![עדכון עם COMMIT](https://github.com/user-attachments/assets/91d3c695-a598-4368-92ad-464cc788ab68)


---

## ✏️ חלק 5: עדכונים (UPDATE)

### ✅ עלאת שכר לעובדים עם פחות מ‏10 הזמנות

```sql
UPDATE Employee
SET salary = salary * 1.1
WHERE employee_id IN (
  SELECT e.employee_id
  FROM Employee e
  LEFT JOIN Orders o ON e.employee_id = o.employee_id
  GROUP BY e.employee_id
  HAVING COUNT(o.order_id) < 10
);
```

![העלאת שכר לעובדים עם פחות מ-10 הזמנות](https://github.com/user-attachments/assets/6b74ff59-5aa4-4c10-b5a1-0e52048148d9)


---

### ✅ שינוי סטטוס להזמנות ישנות

```sql
UPDATE Orders
SET status = 'archived'
WHERE order_date < CURRENT_DATE - INTERVAL '6 months' AND status = 'open';
```

![שינוי סטטוס להזמנות ישנות](https://github.com/user-attachments/assets/8fca0640-e32d-47b8-a18b-e3bcb1229279)


---

### ✅ עדכון זמינות שולחנות שלא נוקו

```sql
UPDATE Restaurant_Table
SET is_available = 'N'
WHERE last_cleaned < CURRENT_DATE - INTERVAL '7 days';
```


![עדכון זמינות שלחנות שלא נוקו](https://github.com/user-attachments/assets/13a2bcbf-c4bb-4cd7-918c-d87fb86e5140)



### לסיכום:
### בשלב זה יישמנו שאילתות מתקדמות כולל חישובים, תנאים, תתי-שאילתות, עדכונים ומחיקות בהתאם לדרישות העסקיות של מסעדה. ווידאנו שהטבלאות מנוהלות בצורה תקינה, והוספנו אילוצים למניעת נתונים לא תקפים. כמו כן תרגלנו פעולות ROLLBACK ו-COMMIT כדי להבין את השפעתן על ניהול שינויים במסד הנתונים. כל הפעולות תועדו בצילומי מסך ואורגנו לפי חלקים ברורים לצורך הבדיקה.

