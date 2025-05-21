
# שלב ד – תכנות (PL/pgSQL)

## 🎯 תיאור כללי
בשלב זה נכתבו פונקציות, פרוצדורות, טריגרים ותוכניות ראשיות בשפת PL/pgSQL, הפועלות על בסיס הנתונים של מערכת ניהול מסעדה ואירועים. מטרת הקוד היא לתרגל שימוש בפונקציונליות מתקדמת של PostgreSQL בצורה מובנית, תוך שימוש באלמנטים של תכנות מונחה אירועים ונתונים.

## 📁 מבנה התיקיות והקבצים

```
שלב ד/
│
├── function_get_average_order_total.sql
├── function_get_total_payments_by_method.sql
│
├── procedure_update_order_status.sql
├── procedure_add_dish_to_order.sql
│
├── trigger_log_payment_insert.sql
├── trigger_log_order_delete.sql
│
├── main_program_1.sql
├── main_program_2.sql
│
├── backup 4    # גיבוי של בסיס הנתונים
├── דו"ח שלב ד.docx        # דו"ח מפורט עם הסברים, קוד, ותמונות מסך
├── README.md              # קובץ זה
```

## 🧠 פירוט התוכניות

### 📌 פונקציות

1. `get_average_order_total(customer_id)`
   - מחזירה את ממוצע ההזמנות של לקוח לפי ה-ID שלו.
   - מדגימה שימוש ב-`SELECT INTO` ובטיפול בערכים חסרים (`NULL`).

![פונקציה 1-סכום ההזמנות הממוצע ללקוח במסעדה](https://github.com/user-attachments/assets/0498d776-990a-47d7-8330-7c77920bee72)

2. `get_total_payments_by_method(method)`
   - מחזירה את סכום כל התשלומים לפי שיטת תשלום מסוימת (Cash / Credit וכו').
   - שימוש ב-`JOIN` בין Orders ל-Payment.

![פונקציה 2- סכום כל התשלומים לפי אמצעי תשלום  ](https://github.com/user-attachments/assets/fb7dbb44-e4f6-4566-bb29-c52c8aa602e9)

### 📌 פרוצדורות

1. `update_order_status(order_id, new_status)`
   - מעדכנת את סטטוס ההזמנה (למשל מ-"Pending" ל-"Completed").
   - כוללת טיפול בחריגה במידה וההזמנה לא קיימת.

![פרצדורה 1-מעדכנת את סטטוס ההזמנה](https://github.com/user-attachments/assets/9796b131-5dba-4e22-bb8d-cb0f907444d4)


2. `add_dish_to_order(order_id, dish_id, quantity)`
   - מוסיפה מנה להזמנה קיימת ומעדכנת את הסכום הכולל.
   - כולל שימוש ב־`UPDATE`, `INSERT`, ו־`SELECT`.

![פרצדורה 2- מוסיפה מנה להזמנה](https://github.com/user-attachments/assets/2328a160-e116-4e5f-9d26-d7eec4734e18)


### 📌 טריגרים

1. `trg_after_payment_insert`
   - מופעל לאחר הוספת תשלום חדש.
   - כותב רשומה ללוג עם תאריך וזמן הפעולה.

![טריגר 1- כשרושמים תשלום חדש – כותב ללוג](https://github.com/user-attachments/assets/7ff18c90-d434-4fd8-80ee-3fa7e6ec8189)


2. `trg_before_payment_delete`
   - מופעל לפני מחיקת ,תשלום
   - שומר את מזהה התשלום והזמן בטבלת לוג.

![טריגר 2- לפני שמוחקים הזמנה – מעתיקים אותה ללוג](https://github.com/user-attachments/assets/2afed905-70b9-4680-bb6b-d93c5311ea8f)


### 📌 תוכניות ראשיות (Main Programs)

1. `main_program_1`
   - קוראת לפונקציה `get_average_order_total` ולפרוצדורה `update_order_status`.

![Main 1 – הפעלת פונקציה + פרוצדורה](https://github.com/user-attachments/assets/f93ab376-469a-4a0e-939d-17b492c3d659)


2. `main_program_2`
   - קוראת לפונקציה `get_total_payments_by_method` ולפרוצדורה `add_dish_to_order`.

![Main 2 – הפעלת פונקציה + פרוצדורה](https://github.com/user-attachments/assets/19022a38-d063-4faf-8554-bdbc7394d5c3)


## 🧪 בדיקות והפעלה

- כל פונקציה נבדקה עם פקודת `SELECT` וקלט לדוגמה.
- כל פרוצדורה נבדקה עם `CALL` ומוצגת בתמונות מסך בדו"ח.
- תוכניות ראשיות נבחנו באמצעות בלוק `DO $$ ... $$` עם `RAISE NOTICE`.
- תוצאת פעולות נבחנה ע"י שאילתות `SELECT` על הטבלאות הרלוונטיות (Orders, Payment_Log וכו').

## 🗂 גיבוי
קובץ `backup4.backup` מכיל את המצב המלא של בסיס הנתונים לאחר הרצת התוכניות. ניתן לשחזר אותו ב־pgAdmin.

## 🏷 Git Tag
נוצר TAG בשם `Stage_D` לציון נקודת סיום שלב זה.


