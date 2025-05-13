# שלב ב – שאילתות ואילוצים




בשלב זה ביצענו שאילתות מורכבות לבסיס הנתונים שנבנה בשלב א, כולל פעולות SELECT, מחיקות, עדכונים, אילוצים, ושימוש בפקודות ROLLBACK ו-COMMIT. מטרת השלב היא לתרגל שליפה ותחזוקה של נתונים בצורה מקצועית, תוך שמירה על שלמות הנתונים וקישוריות נכונה בין הטבלאות.
---

## ✫️ חלק 1: אילוצים (Constraints)

### ✅ אילוץ 1 – NOT NULL על שם לקוח

```sql
ALTER TABLE Customer
ALTER COLUMN full_name SET NOT NULL;
```

![תרגיל 2/תמונות שאילתות/constraints/אילוץ_CHECK.png](images/אילוץ%20NOT%20NULL.png)

---

### ✅ אילוץ 2 – CHECK על מחיר מנה

```sql
ALTER TABLE Dish DROP CONSTRAINT IF EXISTS chk_price_positive;
ALTER TABLE Dish ADD CONSTRAINT chk_price_positive CHECK (price >= 0);
```

![אילוץ CHECK](images/אילוץ%20CHECK.png)

---

### ✅ אילוץ 3 – DEFAULT לזמינות שולחן

```sql
ALTER TABLE Restaurant_Table
ALTER COLUMN is_available SET DEFAULT 'Y';
```

![תרגיל 2/תמונות שאילתות/constraints/אילוץ DEFAULT.png](images/אילוץ%20DEFAULT.png)

---

## 🗑️ חלק 2: שאילתות מחיקה (DELETE)

### ❌ מחיקת מנות שלא הוזמנו כלל

```sql
DELETE FROM Dish
WHERE dish_id NOT IN (
  SELECT DISTINCT dish_id FROM Order_Details
);
```

![מחיקה 1](images/delete1.png)

---

### ❌ מחיקת מנות יקרות שלא הוזמנו

```sql
DELETE FROM Dish
WHERE price > 100 AND dish_id NOT IN (
  SELECT dish_id FROM Order_Details
);
```

![מחיקה 2](images/delete2.png)

---

### ❌ מחיקת שולחנות שלא היו בשימוש

```sql
DELETE FROM Restaurant_Table
WHERE table_id NOT IN (
  SELECT table_id FROM Orders
);
```

![תרגיל 2/תמונות שאילתות/DELETE Queries/מחיקת טבלאות שלא בשימוש.png](images/delete3.png)

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

![select1](images/select1.png)

---

### ✅ שאילתא 2 – כל מלצר לפי שנה

```sql
SELECT e.name, EXTRACT(YEAR FROM o.order_date) AS year, SUM(o.total_amount) AS income
FROM Employee e
JOIN Orders o ON e.employee_id = o.employee_id
GROUP BY e.name, year
ORDER BY income DESC;
```

![select2](images/select2.png)

---

### ✅ שאילתא 3 – ממוצע כמות לפי קטגוריה

```sql
SELECT d.category, AVG(od.quantity) AS avg_quantity
FROM Order_Details od
JOIN Dish d ON od.dish_id = d.dish_id
GROUP BY d.category
ORDER BY avg_quantity DESC;
```

![select3](images/select3.png)

---

### ✅ שאילתא 4 – שולחנות שלא נוקו בשבוע אחרון

```sql
SELECT table_id, seats, last_cleaned
FROM Restaurant_Table
WHERE last_cleaned < CURRENT_DATE - INTERVAL '7 days';
```

![select4](images/select4.png)

---

### ✅ שאילתא 5 – מנות טבעוניות שלא הוזמנו

```sql
SELECT d.name, d.category
FROM Dish d
LEFT JOIN Order_Details od ON d.dish_id = od.dish_id
WHERE od.order_id IS NULL AND d.is_vegan = 'Y';
```

![select5](images/select5.png)

---

### ✅ שאילתא 6 – הזמנות ביום ראשון

```sql
SELECT o.order_id, c.full_name, o.order_date
FROM Orders o
JOIN Customer c ON o.customer_id = c.customer_id
WHERE EXTRACT(DOW FROM o.order_date) = 0;
```

![select6](images/select6.png)

---

### ✅ שאילתא 7 – לקוחות שהוציאו מעל 50 ש"ח

```sql
SELECT c.full_name, SUM(o.total_amount) AS total_spent
FROM Customer c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.full_name
HAVING SUM(o.total_amount) > 50;
```

![select7](images/select7.png)

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

![select8](images/select8.png)

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

![rollback](images/rollback.png)

---

### ✅ עדכון קבוע עם COMMIT

```sql
BEGIN;
UPDATE Dish SET price = price * 0.9;
SELECT * FROM Dish;
COMMIT;
SELECT * FROM Dish;
```

![commit](images/commit.png)

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

![update1](images/update1.png)

---

### ✅ שינוי סטטוס להזמנות ישנות

```sql
UPDATE Orders
SET status = 'archived'
WHERE order_date < CURRENT_DATE - INTERVAL '6 months' AND status = 'open';
```

![update2](images/update2.png)

---

### ✅ עדכון זמינות שולחנות שלא נוקו

```sql
UPDATE Restaurant_Table
SET is_available = 'N'
WHERE last_cleaned < CURRENT_DATE - INTERVAL '7 days';
```

![update3](images/update3.png)



### לסיכום:
### בשלב זה יישמנו שאילתות מתקדמות כולל חישובים, תנאים, תתי-שאילתות, עדכונים ומחיקות בהתאם לדרישות העסקיות של מסעדה. ווידאנו שהטבלאות מנוהלות בצורה תקינה, והוספנו אילוצים למניעת נתונים לא תקפים. כמו כן תרגלנו פעולות ROLLBACK ו-COMMIT כדי להבין את השפעתן על ניהול שינויים במסד הנתונים. כל הפעולות תועדו בצילומי מסך ואורגנו לפי חלקים ברורים לצורך הבדיקה.

