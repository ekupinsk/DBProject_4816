CREATE TABLE Order_Details
(
  order_id_ INT NOT NULL,
  dish_id INT NOT NULL,
  quantity INT NOT NULL,
  note VARCHAR(255) NOT NULL,
  PRIMARY KEY (order_id_)
);

CREATE TABLE Employee
(
  employee_id INT NOT NULL,
  name VARCHAR(100) NOT NULL,
  hire_date DATE NOT NULL,
  salary NUMERIC(10,2) NOT NULL,
  PRIMARY KEY (employee_id)
);

CREATE TABLE Table
(
  table_id INT NOT NULL,
  seats INT NOT NULL,
  is_available CHAR NOT NULL,
  last_cleaned DATE NOT NULL,
  PRIMARY KEY (table_id)
);

CREATE TABLE Order
(
  order_id INT NOT NULL,
  customer_id INT NOT NULL,
  order_date DATE NOT NULL,
  status VARCHAR(30) NOT NULL,
  total_amount NUMERIC(8,2) NOT NULL,
  order_id_ INT NOT NULL,
  table_id INT NOT NULL,
  employee_id INT,
  PRIMARY KEY (order_id),
  FOREIGN KEY (order_id_) REFERENCES Order_Details(order_id_),
  FOREIGN KEY (table_id) REFERENCES Table(table_id),
  FOREIGN KEY (employee_id) REFERENCES Employee(employee_id),
  UNIQUE (customer_id)
);

CREATE TABLE Dish
(
  dish_id INT NOT NULL,
  name VARCHAR(100) NOT NULL,
  price NUMERIC(6,2) NOT NULL,
  category VARCHAR(50) NOT NULL,
  is_vegan CHAR(1) NOT NULL,
  order_id_ INT NOT NULL,
  PRIMARY KEY (dish_id),
  FOREIGN KEY (order_id_) REFERENCES Order_Details(order_id_)
);

CREATE TABLE Customer
(
  customer_id INT NOT NULL,
  full_name VARCHAR(100) NOT NULL,
  phone_number VARCHAR(20) NOT NULL,
  email VARCHAR(100) NOT NULL,
  join_date DATE NOT NULL,
  order_id INT NOT NULL,
  PRIMARY KEY (customer_id),
  FOREIGN KEY (order_id) REFERENCES Order(order_id)
);