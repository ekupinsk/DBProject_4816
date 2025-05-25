import tkinter as tk
from tkinter import messagebox

def open_customers():
    import customers
    customers.show_window()

def open_employees():
    import employees
    employees.show_window()

def open_orders():
    import orders
    orders.show_window()

def open_queries():
    import queries
    queries.show_window()

root = tk.Tk()
root.title("DB Project - Menu")
root.geometry("300x250")

tk.Label(root, text="Main Menu", font=("Arial", 16)).pack(pady=10)

tk.Button(root, text="Customers", width=20, command=open_customers).pack(pady=5)
tk.Button(root, text="Employees", width=20, command=open_employees).pack(pady=5)
tk.Button(root, text="Orders", width=20, command=open_orders).pack(pady=5)
tk.Button(root, text="Run Queries", width=20, command=open_queries).pack(pady=5)

tk.Button(root, text="Exit", width=20, command=root.quit).pack(pady=20)

root.mainloop()
