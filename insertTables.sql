-- לקוחות
INSERT INTO Customer VALUES (1, 'Alice Levi', '0501234567', 'alice@example.com', TO_DATE('2022-01-15','YYYY-MM-DD'));
INSERT INTO Customer VALUES (2, 'David Cohen', '0529876543', 'david@example.com', TO_DATE('2023-05-10','YYYY-MM-DD'));
INSERT INTO Customer VALUES (3, 'Miriam Azulay', '0534567890', 'miriam@example.com', TO_DATE('2024-03-22','YYYY-MM-DD'));

-- עובדים
INSERT INTO Employee VALUES (1, 'Yossi Mizrahi', 'Waiter', TO_DATE('2021-06-01','YYYY-MM-DD'), 5800);
INSERT INTO Employee VALUES (2, 'Sara Ben-David', 'Chef', TO_DATE('2020-03-18','YYYY-MM-DD'), 7200);
INSERT INTO Employee VALUES (3, 'Ronit Peretz', 'Manager', TO_DATE('2019-11-27','YYYY-MM-DD'), 9000);

-- שולחנות
INSERT INTO Table VALUES (1, 4, 'TRUE', TO_DATE('2025-04-08','YYYY-MM-DD'));
INSERT INTO Table VALUES (2, 2, 'FALSE', TO_DATE('2025-04-07','YYYY-MM-DD'));
INSERT INTO Table VALUES (3, 6, 'TRUE', TO_DATE('2025-04-06','YYYY-MM-DD'));

-- מנות
INSERT INTO Dish VALUES (1, 'Pizza Margherita', 42.50, 'Main Course', 'FALSE');
INSERT INTO Dish VALUES (2, 'Green Salad', 25.00, 'Starter', 'TRUE');
INSERT INTO Dish VALUES (3, 'Chocolate Cake', 29.90, 'Dessert', 'FALSE');

-- הזמנות
INSERT INTO "Order" VALUES (100, 1, 1, 1, TO_DATE('2025-04-08','YYYY-MM-DD'), 'Completed', 97.50);
INSERT INTO "Order" VALUES (101, 2, 2, 2, TO_DATE('2025-04-07','YYYY-MM-DD'), 'Preparing', 25.00);
INSERT INTO "Order" VALUES (102, 3, 3, 3, TO_DATE('2025-04-06','YYYY-MM-DD'), 'Cancelled', 0.00);

-- פרטי הזמנות
INSERT INTO Order_Details VALUES (100, 1, 2, 'Extra cheese');
INSERT INTO Order_Details VALUES (100, 3, 1, 'Warm please');
INSERT INTO Order_Details VALUES (101, 2, 1, 'No dressing');
