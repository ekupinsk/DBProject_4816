import tkinter as tk
from tkinter import ttk, messagebox
from db import get_connection

def show_window():
    window = tk.Toplevel()
    window.title("ניהול עובדים")
    window.geometry("600x400")

    tree = ttk.Treeview(window, columns=("ID", "Name", "Hire Date", "Salary"), show="headings")
    for col in tree["columns"]:
        tree.heading(col, text=col)
        tree.column(col, width=100)
    tree.pack(pady=10)

    def load_employees():
        try:
            conn = get_connection()
            cur = conn.cursor()
            cur.execute("SELECT employee_id, name, hire_date, salary FROM Employee")
            rows = cur.fetchall()
            tree.delete(*tree.get_children())
            for row in rows:
                tree.insert("", tk.END, values=row)
            conn.close()
        except Exception as e:
            messagebox.showerror("שגיאה", str(e))

    # טופס
    form_frame = tk.Frame(window)
    form_frame.pack(pady=10)

    tk.Label(form_frame, text="מזהה עובד (ID)").grid(row=0, column=0)
    id_entry = tk.Entry(form_frame)
    id_entry.grid(row=0, column=1)

    tk.Label(form_frame, text="שם").grid(row=1, column=0)
    name_entry = tk.Entry(form_frame)
    name_entry.grid(row=1, column=1)

    tk.Label(form_frame, text="תאריך קבלה (yyyy-mm-dd)").grid(row=2, column=0)
    hire_entry = tk.Entry(form_frame)
    hire_entry.grid(row=2, column=1)

    tk.Label(form_frame, text="שכר").grid(row=3, column=0)
    salary_entry = tk.Entry(form_frame)
    salary_entry.grid(row=3, column=1)

    def add_employee():
        try:
            conn = get_connection()
            cur = conn.cursor()
            cur.execute("""
                INSERT INTO Employee (employee_id, name, hire_date, salary)
                VALUES (%s, %s, %s, %s)
            """, (
                id_entry.get(),
                name_entry.get(),
                hire_entry.get(),
                salary_entry.get()
            ))
            conn.commit()
            conn.close()
            messagebox.showinfo("הצלחה", "העובד נוסף בהצלחה!")
            load_employees()
        except Exception as e:
            messagebox.showerror("שגיאה", str(e))

    tk.Button(window, text="הוסף עובד", command=add_employee).pack(pady=5)
    tk.Button(window, text="רענן נתונים", command=load_employees).pack(pady=5)

    load_employees()
