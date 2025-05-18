-- Customers
INSERT INTO Customer VALUES (1, 'Alice Levi', '0501234567', 'alice@example.com', '2022-01-15');
INSERT INTO Customer VALUES (2, 'David Cohen', '0529876543', 'david@example.com', '2023-05-10');
INSERT INTO Customer VALUES (3, 'Miriam Azulay', '0534567890', 'miriam@example.com', '2024-03-22');

-- Dishes
INSERT INTO Dish VALUES (1, 'Pizza Margherita', 42.50, 'Main Course', 'F');
INSERT INTO Dish VALUES (2, 'Green Salad', 25.00, 'Starter', 'T');
INSERT INTO Dish VALUES (3, 'Chocolate Cake', 29.90, 'Dessert', 'F');

-- Employees
INSERT INTO Employee VALUES (1, 'Yossi Mizrahi', '2021-06-01', 5800.00);
INSERT INTO Employee VALUES (2, 'Sara Ben-David', '2020-03-18', 7200.00);
INSERT INTO Employee VALUES (3, 'Ronit Peretz', '2019-11-27', 9000.00);

-- Restaurant_Table
INSERT INTO Restaurant_Table VALUES (1, 4, 'T', '2025-04-08');
INSERT INTO Restaurant_Table VALUES (2, 2, 'F', '2025-04-07');
INSERT INTO Restaurant_Table VALUES (3, 6, 'T', '2025-04-06');

-- Orders
INSERT INTO Orders VALUES (100, 1, 1, 1, '2025-04-08', 'Completed', 97.50);
INSERT INTO Orders VALUES (101, 2, 2, 2, '2025-04-07', 'Preparing', 25.00);
INSERT INTO Orders VALUES (102, 3, 3, 3, '2025-04-06', 'Cancelled', 0.00);

-- Order_Details
INSERT INTO Order_Details VALUES (100, 1, 2, 'Extra cheese');
INSERT INTO Order_Details VALUES (100, 3, 1, 'Warm please');
INSERT INTO Order_Details VALUES (101, 2, 1, 'No dressing');

--Payment
INSERT INTO Payment VALUES  (1,'Card', 'Pending', '2024-06-02', 102);
INSERT INTO Payment VALUES  (2,'Cash', 'Paid', '2024-06-01', 101);
INSERT INTO Payment VALUES  (3,'Card', 'Pending', '2024-06-02', 101);
