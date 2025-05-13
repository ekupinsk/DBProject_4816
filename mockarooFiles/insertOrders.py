
import random
from datetime import datetime, timedelta

def random_date(start, end):
    return start + timedelta(days=random.randint(0, int((end - start).days)))

statuses = ['Preparing', 'Completed', 'Cancelled']
insert_template = "INSERT INTO \"Order\" (order_id, customer_id, order_date, status, total_amount, table_id, employee_id) VALUES ({}, {}, TO_DATE('{}', 'YYYY-MM-DD'), '{}', {:.2f}, {}, {});"

start_date = datetime(2023, 1, 1)
end_date = datetime(2025, 4, 1)

with open("insertOrders.sql", "w") as file:
    for i in range(1000, 1400):  # 400 orders
        customer_id = random.randint(1, 100)
        order_date = random_date(start_date, end_date).strftime("%Y-%m-%d")
        status = random.choice(statuses)
        total_amount = random.uniform(20, 300)
        table_id = random.randint(1, 30)
        employee_id = random.randint(1, 10)
        file.write(insert_template.format(i, customer_id, order_date, status, total_amount, table_id, employee_id) + "\n")
