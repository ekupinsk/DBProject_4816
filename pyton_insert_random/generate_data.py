import random
from faker import Faker
from datetime import datetime
from pathlib import Path

fake = Faker()
NUM_ROWS = 400

def rand_bool_char():
    return random.choice(['T', 'F'])

def rand_category():
    return random.choice(['Main Course', 'Starter', 'Dessert'])

def rand_status():
    return random.choice(['Completed', 'Preparing', 'Cancelled'])

def rand_date(start_year=2022, end_year=2025):
    start = datetime(start_year, 1, 1)
    end = datetime(end_year, 12, 31)
    return fake.date_between(start_date=start, end_date=end).strftime('%Y-%m-%d')

sql_lines = []

# 1. Customer
sql_lines.append("-- Customer")
for i in range(1, NUM_ROWS + 1):
    full_name = fake.name()[:20].replace("'", "''")
    phone = fake.phone_number()[:20]
    email = fake.email()
    join_date = rand_date()
    sql_lines.append(
        f"INSERT INTO Customer VALUES ({i}, '{full_name}', '{phone}', '{email}', '{join_date}');"
    )

# 2. Dish
sql_lines.append("-- Dish")
for i in range(1, NUM_ROWS + 1):
    name = fake.word().capitalize() + " " + random.choice(["Dish", "Meal", "Plate"])
    price = round(random.uniform(10, 100), 2)
    category = rand_category()
    is_vegan = rand_bool_char()
    sql_lines.append(
        f"INSERT INTO Dish VALUES ({i}, '{name}', {price}, '{category}', '{is_vegan}');"
    )

# 3. Employee
sql_lines.append("-- Employee")
for i in range(1, NUM_ROWS + 1):
    salary = round(random.uniform(5000, 15000), 2)
    sql_lines.append(
        f"INSERT INTO Employee VALUES ({i}, '{fake.name()}', '{rand_date(2015, 2023)}', {salary});"
    )

# 4. Restaurant_Table
sql_lines.append("-- Restaurant_Table")
for i in range(1, NUM_ROWS + 1):
    seats = random.randint(2, 10)
    is_available = rand_bool_char()
    last_cleaned = rand_date(2023, 2025)
    sql_lines.append(
        f"INSERT INTO Restaurant_Table VALUES ({i}, {seats}, '{is_available}', '{last_cleaned}');"
    )

# 5. Orders
sql_lines.append("-- Orders")
for i in range(1, NUM_ROWS + 1):
    cust_id = random.randint(1, NUM_ROWS)
    emp_id = random.randint(1, NUM_ROWS)
    table_id = random.randint(1, NUM_ROWS)
    status = rand_status()
    total = round(random.uniform(20, 300), 2)
    sql_lines.append(
        f"INSERT INTO Orders VALUES ({i}, {cust_id}, {emp_id}, {table_id}, '{rand_date(2024, 2025)}', '{status}', {total});"
    )

# 6. Order_Details
sql_lines.append("-- Order_Details")
for _ in range(NUM_ROWS):
    order_id = random.randint(1, NUM_ROWS)
    dish_id = random.randint(1, NUM_ROWS)
    quantity = random.randint(1, 5)
    note = fake.sentence(nb_words=3).replace("'", "''")
    sql_lines.append(
        f"INSERT INTO Order_Details VALUES ({order_id}, {dish_id}, {quantity}, '{note}');"
    )

# 7. Payment
sql_lines.append("-- Payment")
payment_methods = ['Cash', 'Card', 'PayPal']
payment_statuses = ['Paid', 'Pending', 'Failed']

for i in range(1, NUM_ROWS + 1):
    method = random.choice(payment_methods)[:20]
    status = random.choice(payment_statuses)[:20]
    payment_date = rand_date(2024, 2025)
    order_id = i  # Assumes each payment corresponds to an order
    sql_lines.append(
        f"INSERT INTO Payment VALUES ({i}, '{method}', '{status}', '{payment_date}', {order_id});"
    )

# Save to file
sql_output = "\n".join(sql_lines)
Path("insert_random_data.sql").write_text(sql_output, encoding="utf-8")
print("Data generated and saved to insert_random_data.sql")
