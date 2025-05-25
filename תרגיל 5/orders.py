import tkinter as tk
from tkinter import ttk, messagebox
from db import get_connection

def show_window():
    window = tk.Toplevel()
    window.title("ניהול הזמנות")
    window.geometry("750x500")

    tree = ttk.Treeview(window, columns=("ID", "Customer", "Employee", "Table", "Date", "Status", "Total"), show="headings")
    for col in tree["columns"]:
        tree.heading(col, text=col)
        tree.column(col, width=100)
    tree.pack(pady=10)

    def load_orders():
        try:
            conn = get_connection()
            cur = conn.cursor()
            cur.execute("""
                SELECT o.order_id, c.full_name, e.name, t.table_id,
                       o.order_date, o.status, o.total_amount
                FROM Orders o
                JOIN Customer c ON o.customer_id = c.customer_id
                JOIN Employee e ON o.employee_id = e.employee_id
                JOIN Restaurant_Table t ON o.table_id = t.table_id
            """)
            rows = cur.fetchall()
            tree.delete(*tree.get_children())
            for row in rows:
                tree.insert("", tk.END, values=row)
            conn.close()
        except Exception as e:
            messagebox.showerror("שגיאה", str(e))

    form = tk.Frame(window)
    form.pack(pady=10)

    tk.Label(form, text="מזהה הזמנה").grid(row=0, column=0)
    order_id = tk.Entry(form)
    order_id.grid(row=0, column=1)

    tk.Label(form, text="לקוח").grid(row=1, column=0)
    customer_cb = ttk.Combobox(form, width=30)
    customer_cb.grid(row=1, column=1)

    tk.Label(form, text="עובד").grid(row=2, column=0)
    employee_cb = ttk.Combobox(form, width=30)
    employee_cb.grid(row=2, column=1)

    tk.Label(form, text="שולחן").grid(row=3, column=0)
    table_cb = ttk.Combobox(form, width=30)
    table_cb.grid(row=3, column=1)

    tk.Label(form, text="תאריך (yyyy-mm-dd)").grid(row=4, column=0)
    date_entry = tk.Entry(form)
    date_entry.grid(row=4, column=1)

    tk.Label(form, text="סטטוס").grid(row=5, column=0)
    status_entry = tk.Entry(form)
    status_entry.grid(row=5, column=1)

    tk.Label(form, text="סכום כולל").grid(row=6, column=0)
    amount_entry = tk.Entry(form)
    amount_entry.grid(row=6, column=1)

    def load_dropdowns():
        conn = get_connection()
        cur = conn.cursor()

        cur.execute("SELECT customer_id, full_name FROM Customer")
        customers = cur.fetchall()
        customer_cb["values"] = [f"{cid} - {name}" for cid, name in customers]

        cur.execute("SELECT employee_id, name FROM Employee")
        employees = cur.fetchall()
        employee_cb["values"] = [f"{eid} - {name}" for eid, name in employees]

        cur.execute("SELECT table_id FROM Restaurant_Table WHERE is_available = 'T'")
        tables = cur.fetchall()
        table_cb["values"] = [str(tid[0]) for tid in tables]

        conn.close()

    def add_order():
        try:
            cid = int(customer_cb.get().split(" - ")[0])
            eid = int(employee_cb.get().split(" - ")[0])
            tid = int(table_cb.get())
            conn = get_connection()
            cur = conn.cursor()
            cur.execute("""
                INSERT INTO Orders (order_id, customer_id, employee_id, table_id, order_date, status, total_amount)
                VALUES (%s, %s, %s, %s, %s, %s, %s)
            """, (
                order_id.get(),
                cid,
                eid,
                tid,
                date_entry.get(),
                status_entry.get(),
                amount_entry.get()
            ))
            conn.commit()
            conn.close()
            messagebox.showinfo("הצלחה", "הזמנה נוספה!")
            load_orders()
        except Exception as e:
            messagebox.showerror("שגיאה", str(e))

    tk.Button(window, text="הוסף הזמנה", command=add_order).pack(pady=5)
    tk.Button(window, text="רענן", command=lambda: [load_orders(), load_dropdowns()]).pack()

    load_orders()
    load_dropdowns()
