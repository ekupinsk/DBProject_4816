import tkinter as tk
from tkinter import ttk, messagebox
from db import get_connection

def show_window():
    window = tk.Toplevel()
    window.title("ניהול לקוחות")
    window.geometry("600x400")

    # טבלה להצגת נתונים
    tree = ttk.Treeview(window, columns=("ID", "Name", "Phone", "Email", "Join Date"), show="headings")
    for col in tree["columns"]:
        tree.heading(col, text=col)
        tree.column(col, width=100)
    tree.pack(pady=10)

    def load_customers():
        try:
            conn = get_connection()
            cur = conn.cursor()
            cur.execute("SELECT customer_id, full_name, phone_number, email, join_date FROM Customer")
            rows = cur.fetchall()
            tree.delete(*tree.get_children())  # נקה טבלה
            for row in rows:
                tree.insert("", tk.END, values=row)
            conn.close()
        except Exception as e:
            messagebox.showerror("שגיאה", str(e))

    # טופס הוספה
    form_frame = tk.Frame(window)
    form_frame.pack()

    tk.Label(form_frame, text="מזהה לקוח (ID)").grid(row=0, column=0)
    id_entry = tk.Entry(form_frame)
    id_entry.grid(row=0, column=1)

    tk.Label(form_frame, text="שם מלא").grid(row=1, column=0)
    name_entry = tk.Entry(form_frame)
    name_entry.grid(row=1, column=1)

    tk.Label(form_frame, text="טלפון").grid(row=2, column=0)
    phone_entry = tk.Entry(form_frame)
    phone_entry.grid(row=2, column=1)

    tk.Label(form_frame, text="אימייל").grid(row=3, column=0)
    email_entry = tk.Entry(form_frame)
    email_entry.grid(row=3, column=1)

    tk.Label(form_frame, text="תאריך הצטרפות (yyyy-mm-dd)").grid(row=4, column=0)
    date_entry = tk.Entry(form_frame)
    date_entry.grid(row=4, column=1)

    def add_customer():
        try:
            conn = get_connection()
            cur = conn.cursor()
            cur.execute("""
                INSERT INTO Customer (customer_id, full_name, phone_number, email, join_date)
                VALUES (%s, %s, %s, %s, %s)
            """, (
                id_entry.get(),
                name_entry.get(),
                phone_entry.get(),
                email_entry.get(),
                date_entry.get()
            ))

            conn.commit()
            conn.close()
            messagebox.showinfo("הצלחה", "הלקוח נוסף בהצלחה!")
            load_customers()
        except Exception as e:
            messagebox.showerror("שגיאה", str(e))

    tk.Button(window, text="הוסף לקוח", command=add_customer).pack(pady=5)
    tk.Button(window, text="רענן נתונים", command=load_customers).pack(pady=5)

    load_customers()
