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
