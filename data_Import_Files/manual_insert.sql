-- Customer
INSERT INTO Customer VALUES (1001, 'David Levi', '0521234567', 'david.levi@example.com', '2023-01-10');
INSERT INTO Customer VALUES (1002, 'Sarah Cohen', '0549876543', 'sarah.cohen@example.com', '2024-03-12');
INSERT INTO Customer VALUES (1003, 'Yosef Mizrahi', '0506789012', 'yosef.m@example.com', '2022-07-25');

-- Dish
INSERT INTO Dish VALUES (201, 'Spaghetti Plate', 45.00, 'Main Course', 'F');
INSERT INTO Dish VALUES (202, 'Green Vegan Salad', 29.90, 'Starter', 'T');
INSERT INTO Dish VALUES (203, 'Chocolate Cake', 32.50, 'Dessert', 'F');

-- Employee
INSERT INTO Employee VALUES (301, 'Eli Azulay', '2019-04-01', 8800.00);
INSERT INTO Employee VALUES (302, 'Naomi Shaked', '2021-11-15', 7600.00);
INSERT INTO Employee VALUES (303, 'Itay Sharon', '2020-08-21', 9400.00);

-- Restaurant_Table
INSERT INTO Restaurant_Table VALUES (401, 4, 'T', '2025-04-05');
INSERT INTO Restaurant_Table VALUES (402, 2, 'F', '2025-04-04');
INSERT INTO Restaurant_Table VALUES (403, 6, 'T', '2025-04-03');

-- Orders
INSERT INTO Orders VALUES (501, 1001, 301, 401, '2025-04-06', 'Completed', 120.00);
INSERT INTO Orders VALUES (502, 1002, 302, 402, '2025-04-07', 'Preparing', 89.90);
INSERT INTO Orders VALUES (503, 1003, 303, 403, '2025-04-08', 'Cancelled', 0.00);

-- Order_Details
INSERT INTO Order_Details VALUES (501, 201, 2, 'Extra sauce');
INSERT INTO Order_Details VALUES (501, 203, 1, 'No nuts');
INSERT INTO Order_Details VALUES (502, 202, 1, 'No dressing');
