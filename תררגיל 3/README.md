
# פרויקט מסדי נתונים – שלב ג': אינטגרציה ומבטים

## 🔍 תיאור כללי
בשלב ג' של הפרויקט, עבדנו על אינטגרציה בין שני בסיסי נתונים: האחד שפיתחנו בעצמנו עבור מערכת ניהול מסעדה, והשני שקיבלנו מקבוצת פרויקט אחרת, עבור מערכת ניהול אולם אירועים. מטרת התרגיל הייתה להתנסות בהבנה, תכנון ושילוב של מערכות קיימות, תוך שימוש בכלי SQL מתקדמים כולל טבלאות מקשרות (Bridge Tables), VIEWs וכתיבת שאילתות מורכבות.

---

## 🧱 שלב 1: שחזור מערכת האגף הנוסף
- קיבלנו קובץ גיבוי מסוג `custom` מבסיס הנתונים של האולם.
- השתמשנו בכלי `Restore` ב־pgAdmin כדי לשחזר את הנתונים.
- לאחר השחזור, וידאנו שהטבלאות והנתונים קיימים במסד הנתונים שלנו.

---

## 📊 שלב 2: יצירת DSD (Data Structure Diagram)
- מתוך קובץ ה־SQL שנוצר בתהליך השחזור (`createTable.sql`) חילצנו את מבנה הטבלאות.
- יצרנו דיאגרמת DSD באמצעות ERDPlus שתייצג את המבנה של האולם בצורה גרפית.

---
![DSD](https://github.com/user-attachments/assets/75c75a87-98df-4336-9b40-a2f9ddad1b22)


## 🔁 שלב 3: יצירת ERD על פי DSD (Reverse Engineering)
- ביצענו היפוך הנדסה (reverse engineering) מה־DSD אל ERD.
- זיהינו ישויות, קשרים, מפתחות ראשיים וזרים.
---
![erd ](https://github.com/user-attachments/assets/835bbeb7-ae75-408b-9cd9-4cd4b75b589d)



## 🔗 שלב 4: יצירת ERD משולב
- חיברנו בין מערכת המסעדה ומערכת האולם.
- החלטנו **לא לשנות שמות של טבלאות קיימות**, כדי לא לפגוע בקבצי הגיבוי או בתלות הקיימת.
- לשם כך, יצרנו שלוש טבלאות חיבור:

1. `Customer_Link(customer_id, cus_id)` – לקשר בין לקוח של המסעדה ללקוח של האולם.
2. `Also_Works_As(employee_id, emp_id)` – לקשר בין עובדים במערכות.
3. `Order_Event_Link(order_id, event_id)` – לקשר בין הזמנות מהמסעדה לאירועים באולם.


---
![image](https://github.com/user-attachments/assets/a4fcb928-5fc6-4cc0-9dd5-0ef3f3e04f8a)



## 🧩 שלב 5: יצירת סכמת אינטגרציה (Integrate.sql)
- יצרנו קובץ SQL שמכיל **רק את טבלאות הקישור**.
- לא נגעו טבלאות מקוריות – כל האינטגרציה נעשתה דרך הוספה בלבד.
- הקובץ כולל פקודות `CREATE TABLE` עם מפתחות זרים לשמירה על עקביות.

---
![אנטגרציה](https://github.com/user-attachments/assets/ec842619-f155-4aa1-837c-7bcfdb18efae)
![DSD](https://github.com/user-attachments/assets/d53a8c41-067d-4876-9f32-14a2600dfa1c)


## 🧪 שלב 6: הזנת נתונים
- יצרנו נתונים לכל הטבלאות של מערכת האולם:
  - לקוחות (Customers)
  - אולמות (Halls)
  - ספקים (Vendors)
  - עובדים (Employees)
  - תפריטים (Menus)
  - אירועים (Events)
  - הזמנות ספקים (Vendor_Orders)
- הקובץ `sample_data_for_friend.sql` כולל `INSERT INTO` עם מפתחות תקינים.
- בנוסף, יצרנו 50 שורות לטבלאות החיבור (`Customer_Link`, `Also_Works_As`, `Order_Event_Link`) בקובץ `insert_links_data_fixed.sql`, עם ערכים בטווח 1–10, כדי להתאים לנתונים הקיימים.
---
![image](https://github.com/user-attachments/assets/3d12eaf8-580f-40af-acd5-dfefaf07de14)
![image](https://github.com/user-attachments/assets/007f522a-1180-4c9f-9ed3-4015fbf2aa7b)
![image](https://github.com/user-attachments/assets/7e5ad12a-a644-47c7-b24b-71761a03a7d2)

## 👁️ שלב 7: יצירת VIEWs ושאילתות

### ✅ View 1 – restaurant_orders_summary
מכיל סיכום של הזמנות ממסעדה, כולל סכום כולל לכל הזמנה:

```sql
CREATE VIEW restaurant_orders_summary AS
SELECT o.order_id, c.full_name, o.order_date,
       SUM(od.quantity * d.price) AS total
FROM Orders o
JOIN Customer c ON o.customer_id = c.customer_id
JOIN Order_Details od ON o.order_id = od.order_id
JOIN Dish d ON od.dish_id = d.dish_id
GROUP BY o.order_id, c.full_name, o.order_date;
```
![View 1 – מסעדה](https://github.com/user-attachments/assets/8d7cdcd7-b90f-4b96-8779-b6736050cef9)

**שאילתות:**
```sql
SELECT * FROM restaurant_orders_summary WHERE total > 200;
SELECT AVG(total_price) FROM restaurant_orders_summary;
```
![שאילתה 1 – הזמנות מעל 200 ](https://github.com/user-attachments/assets/9fe442a4-8979-4c52-b4c1-a5178131e746)
![שאילתה 2 – ממוצע סכום ההזמנה](https://github.com/user-attachments/assets/9b85f9fb-6cb2-4371-a5f0-01818ccdb52b)

---

### ✅ View 2 – hall_event_summary
כולל נתונים על אירועים באולמות:

```sql
CREATE VIEW hall_event_summary AS
SELECT e.event_id, e.event_date, c.cus_name, h.hall_name, e.total_price
FROM Events e
JOIN Customers c ON e.cus_id = c.cus_id
JOIN Halls h ON e.hall_id = h.hall_id;
```
![View 2 – אולם](https://github.com/user-attachments/assets/c742666e-e243-4410-aac5-25600a2b6c06)

**שאילתות:**
```sql
SELECT * FROM hall_event_summary WHERE total_price > 10000;
SELECT * FROM hall_event_summary WHERE hall_name = 'Hall_1';
```
![שאילתה 1 – כל האירועים באולם מסוים](https://github.com/user-attachments/assets/0920749d-3e8b-4709-aefc-bca366cdcf38)

![שאילתה 2 – אירועים יקרים מ־10,000](https://github.com/user-attachments/assets/27550995-87da-403f-a357-10ae1c32cf34)

---

### ✅ View 3 – linked_customers_events_orders
מאחד מידע משתי המערכות:

```sql
CREATE VIEW linked_customers_events_orders AS
SELECT cl.customer_id, c.full_name AS restaurant_name,
       cu.cus_name AS hall_name, e.event_id, o.order_id, o.total_amount
FROM Customer_Link cl
JOIN Customer c ON cl.customer_id = c.customer_id
JOIN Customers cu ON cl.cus_id = cu.cus_id
LEFT JOIN Events e ON cu.cus_id = e.cus_id
LEFT JOIN Orders o ON c.customer_id = o.customer_id;
```
![View 3 – אינטגרטיבי](https://github.com/user-attachments/assets/6ab6c3ea-667a-4a62-8dbb-a7969b4926bc)

**שאילתות:**
```sql
SELECT DISTINCT restaurant_name, hall_name
FROM linked_customers_events_orders
WHERE event_id IS NOT NULL AND order_id IS NOT NULL;

SELECT restaurant_name, SUM(total_amount)
FROM linked_customers_events_orders
WHERE event_id IS NOT NULL
GROUP BY restaurant_name;
```

![שאילתה 1 – לקוחות שהיו גם במסעדה וגם באולם](https://github.com/user-attachments/assets/9bdb4607-1854-49a5-b782-fcf193549f87)
![שאילתה 2 – סכום ההזמנה במסעדה ללקוחות עם אירוע באולם](https://github.com/user-attachments/assets/eb2b0923-41ed-4e6b-8bda-818429375597)

---

## 💾 שלב 8: יצירת גיבוי כולל
לאחר יצירת הטבלאות, הכנסת הנתונים ויצירת המבטים, יצרנו קובץ גיבוי חדש `backup3`.

---

## 📁 קבצים שהוגשו

- ERD אגף האולם
- DSD אגף האולם
- ERD משולב
- DSD אינטגרטיבי
- Integrate.sql
- sample_data_for_friend.sql
- insert_links_data_fixed.sql
- Views.sql (עם כל ה־Views והשאילתות)
- backup3
- README.md ← הקובץ הנוכחי

---

## ✅ סיכום
בשלב ג' ביצענו אינטגרציה מוצלחת של שני בסיסי נתונים תוך שמירה על עקרונות עיצוב נכונים, הוספת טבלאות קשר במקום שינוי מבני, יצירת Views בעלי משמעות וניתוח מידע ממערכות שונות במבט אחיד. שלב זה שיפר את הבנתנו בתכנון מערכות גדולות ובמימוש שאילתות מורכבות.

