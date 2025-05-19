
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

## 🔁 שלב 3: יצירת ERD על פי DSD (Reverse Engineering)
- ביצענו היפוך הנדסה (reverse engineering) מה־DSD אל ERD.
- זיהינו ישויות, קשרים, מפתחות ראשיים וזרים.

---

## 🔗 שלב 4: יצירת ERD משולב
- חיברנו בין מערכת המסעדה ומערכת האולם.
- החלטנו **לא לשנות שמות של טבלאות קיימות**, כדי לא לפגוע בקבצי הגיבוי או בתלות הקיימת.
- לשם כך, יצרנו שלוש טבלאות חיבור:

1. `Customer_Link(customer_id, cus_id)` – לקשר בין לקוח של המסעדה ללקוח של האולם.
2. `Also_Works_As(employee_id, emp_id)` – לקשר בין עובדים במערכות.
3. `Order_Event_Link(order_id, event_id)` – לקשר בין הזמנות מהמסעדה לאירועים באולם.

---

## 🧩 שלב 5: יצירת סכמת אינטגרציה (Integrate.sql)
- יצרנו קובץ SQL שמכיל **רק את טבלאות הקישור**.
- לא נגעו טבלאות מקוריות – כל האינטגרציה נעשתה דרך הוספה בלבד.
- הקובץ כולל פקודות `CREATE TABLE` עם מפתחות זרים לשמירה על עקביות.

---

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

## 👁️ שלב 7: יצירת VIEWs ושאילתות

### ✅ View 1 – restaurant_orders_summary
מכיל סיכום של הזמנות ממסעדה, כולל סכום כולל לכל הזמנה:

```sql
CREATE VIEW restaurant_orders_summary AS
SELECT o.order_id, c.full_name, o.order_date,
       SUM(od.quantity * d.price) AS total_price
FROM Orders o
JOIN Customer c ON o.customer_id = c.customer_id
JOIN Order_Details od ON o.order_id = od.order_id
JOIN Dish d ON od.dish_id = d.dish_id
GROUP BY o.order_id, c.full_name, o.order_date;
```

**שאילתות:**
```sql
SELECT * FROM restaurant_orders_summary WHERE total_price > 200;
SELECT AVG(total_price) FROM restaurant_orders_summary;
```

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

**שאילתות:**
```sql
SELECT * FROM hall_event_summary WHERE total_price > 10000;
SELECT * FROM hall_event_summary WHERE hall_name = 'Hall_1';
```

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

