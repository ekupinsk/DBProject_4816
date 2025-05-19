CREATE TABLE Customers (
  cus_id INT NOT NULL,
  cus_name VARCHAR2(100) NOT NULL,
  cus_phone VARCHAR2(20) NOT NULL,
  PRIMARY KEY (cus_id)
);

CREATE TABLE Halls (
  hall_id INT NOT NULL,
  hall_name VARCHAR2(100) NOT NULL,
  capacity INT NOT NULL,
  guest_price INT NOT NULL,
  hall_address VARCHAR2(200) NOT NULL,
  PRIMARY KEY (hall_id)
);

CREATE TABLE Vendors (
  vendor_id INT NOT NULL,
  company_name VARCHAR2(100) NOT NULL,
  vendor_phone VARCHAR2(20) NOT NULL,
  service_type VARCHAR2(50) NOT NULL,
  PRIMARY KEY (vendor_id)
);

CREATE TABLE Employees (
  emp_id INT NOT NULL,
  emp_name VARCHAR2(100) NOT NULL,
  emp_phone VARCHAR2(20) NOT NULL,
  salary INT NOT NULL,
  role VARCHAR2(50) NOT NULL,
  PRIMARY KEY (emp_id)
);

CREATE TABLE Menus (
  menu_id INT NOT NULL,
  chef VARCHAR2(100) NOT NULL,
  first_course VARCHAR2(100) NOT NULL,
  second_course VARCHAR2(100) NOT NULL,
  dessert VARCHAR2(100) NOT NULL,
  notes VARCHAR2(255) NOT NULL,
  PRIMARY KEY (menu_id)
);

CREATE TABLE Events (
  event_id INT NOT NULL,
  event_type VARCHAR2(50) NOT NULL,
  num_guests INT NOT NULL,
  event_date DATE NOT NULL,
  paid INT NOT NULL,
  total_price INT NOT NULL,
  cus_id INT NOT NULL,
  hall_id INT NOT NULL,
  menu_id INT NOT NULL,
  PRIMARY KEY (event_id),
  FOREIGN KEY (cus_id) REFERENCES Customers(cus_id),
  FOREIGN KEY (hall_id) REFERENCES Halls(hall_id),
  FOREIGN KEY (menu_id) REFERENCES Menus(menu_id)
);

CREATE TABLE Vendor_Orders (
  order_id INT NOT NULL,
  service_date DATE NOT NULL,
  service_price INT NOT NULL,
  event_id INT NOT NULL,
  PRIMARY KEY (order_id),
  FOREIGN KEY (event_id) REFERENCES Events(event_id)
);

CREATE TABLE Serves (
  vendor_id INT NOT NULL,
  order_id INT NOT NULL,
  PRIMARY KEY (vendor_id, order_id),
  FOREIGN KEY (vendor_id) REFERENCES Vendors(vendor_id),
  FOREIGN KEY (order_id) REFERENCES Vendor_Orders(order_id)
);

CREATE TABLE Works (
  emp_id INT NOT NULL,
  event_id INT NOT NULL,
  PRIMARY KEY (emp_id, event_id),
  FOREIGN KEY (emp_id) REFERENCES Employees(emp_id),
  FOREIGN KEY (event_id) REFERENCES Events(event_id)
);

CREATE TABLE Customer (
  customer_id INT NOT NULL,
  full_name VARCHAR(100) NOT NULL,
  phone_number VARCHAR(20) NOT NULL,
  email VARCHAR(100) NOT NULL,
  join_date DATE NOT NULL,
  PRIMARY KEY (customer_id)
);

CREATE TABLE Dish (
  dish_id INT NOT NULL,
  name VARCHAR(100) NOT NULL,
  price NUMERIC(6,2) NOT NULL,
  category VARCHAR(50) NOT NULL,
  is_vegan CHAR(1) NOT NULL,
  PRIMARY KEY (dish_id)
);

CREATE TABLE Employee (
  employee_id INT NOT NULL,
  name VARCHAR(100) NOT NULL,
  hire_date DATE NOT NULL,
  salary NUMERIC(10,2) NOT NULL,
  PRIMARY KEY (employee_id)
);

CREATE TABLE Restaurant_Table (
  table_id INT NOT NULL,
  seats INT NOT NULL,
  is_available CHAR(1) NOT NULL,
  last_cleaned DATE NOT NULL,
  PRIMARY KEY (table_id)
);

CREATE TABLE Orders (
  order_id INT NOT NULL,
  customer_id INT NOT NULL,
  employee_id INT NOT NULL,
  table_id INT NOT NULL,
  order_date DATE NOT NULL,
  status VARCHAR(30) NOT NULL,
  total_amount NUMERIC(8,2) NOT NULL,
  PRIMARY KEY (order_id),
  FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
  FOREIGN KEY (employee_id) REFERENCES Employee(employee_id),
  FOREIGN KEY (table_id) REFERENCES Restaurant_Table(table_id)
);

CREATE TABLE Order_Details (
  order_id INT NOT NULL,
  dish_id INT NOT NULL,
  quantity INT NOT NULL,
  note VARCHAR(255) NOT NULL,
  PRIMARY KEY (order_id, dish_id),
  FOREIGN KEY (dish_id) REFERENCES Dish(dish_id),
  FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

CREATE TABLE Payment (
  payment_id INT NOT NULL,
  payment_method VARCHAR(20) NOT NULL,   
  payment_status VARCHAR(20) NOT NULL,   
  payment_date DATE NOT NULL,
  order_id INT NOT NULL,
  PRIMARY KEY (payment_id), 
  FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

CREATE TABLE Customer_Link
(
  cus_id INT NOT NULL,
  customer_id INT NOT NULL,
  PRIMARY KEY (cus_id, customer_id),
  FOREIGN KEY (cus_id) REFERENCES Customers(cus_id),
  FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

CREATE TABLE Also_Works_As
(
  emp_id INT NOT NULL,
  employee_id INT NOT NULL,
  PRIMARY KEY (emp_id, employee_id),
  FOREIGN KEY (emp_id) REFERENCES Employees(emp_id),
  FOREIGN KEY (employee_id) REFERENCES Employee(employee_id)
);

CREATE TABLE Order_Event_Link	
(
  order_id INT NOT NULL,
  event_id INT NOT NULL,
  PRIMARY KEY (order_id, event_id),
  FOREIGN KEY (order_id) REFERENCES Orders(order_id),
  FOREIGN KEY (event_id) REFERENCES Events(event_id)
);