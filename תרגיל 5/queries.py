import tkinter as tk
from tkinter import ttk, messagebox
from db import get_connection

def show_window():
    window = tk.Toplevel()
    window.title("שאילתות ופרוצדורות")
    window.geometry("700x600")

    #### ---- שאילתה 1: לקוחות בין תאריכים ---- ####
    tk.Label(window, text="לקוחות שהזמינו בין תאריכים", font=("Arial", 12, "bold")).pack(pady=5)

    frame1 = tk.Frame(window)
    frame1.pack()

    tk.Label(frame1, text="מתאריך (yyyy-mm-dd):").grid(row=0, column=0)
    from_date = tk.Entry(frame1)
    from_date.grid(row=0, column=1)

    tk.Label(frame1, text="עד תאריך:").grid(row=1, column=0)
    to_date = tk.Entry(frame1)
    to_date.grid(row=1, column=1)

    result1 = tk.Text(window, height=5, width=80)
    result1.pack()

    def run_query1():
        try:
            conn = get_connection()
            cur = conn.cursor()
            cur.execute("""
                SELECT DISTINCT c.full_name
                FROM Customer c
                JOIN Orders o ON c.customer_id = o.customer_id
                WHERE o.order_date BETWEEN %s AND %s
            """, (from_date.get(), to_date.get()))
            rows = cur.fetchall()
            result1.delete("1.0", tk.END)
            for row in rows:
                result1.insert(tk.END, row[0] + "\n")
            conn.close()
        except Exception as e:
            messagebox.showerror("שגיאה", str(e))

    tk.Button(window, text="הרץ שאילתה", command=run_query1).pack()

    #### ---- שאילתה 2: סכום כולל ---- ####
    tk.Label(window, text="סכום כולל של כל ההזמנות", font=("Arial", 12, "bold")).pack(pady=10)
    result2 = tk.Label(window, text="—", font=("Arial", 11))
    result2.pack()

    def run_query2():
        try:
            conn = get_connection()
            cur = conn.cursor()
            cur.execute("SELECT SUM(total_amount) FROM Orders")
            total = cur.fetchone()[0]
            result2.config(text=f"סה\"כ הכנסות: {total:.2f} ש\"ח")
            conn.close()
        except Exception as e:
            messagebox.showerror("שגיאה", str(e))

    tk.Button(window, text="חשב סכום כולל", command=run_query2).pack()

    #### ---- פונקציה: מספר הזמנות לפי לקוח ---- ####
    tk.Label(window, text="\nבדיקת מספר הזמנות של לקוח", font=("Arial", 12, "bold")).pack(pady=5)
    frame3 = tk.Frame(window)
    frame3.pack()

    tk.Label(frame3, text="מספר לקוח:").grid(row=0, column=0)
    customer_id_entry = tk.Entry(frame3)
    customer_id_entry.grid(row=0, column=1)

    result3 = tk.Label(window, text="—")
    result3.pack()

    def run_function():
        try:
            conn = get_connection()
            cur = conn.cursor()
            cur.execute("SELECT get_order_count(%s)", (customer_id_entry.get(),))
            count = cur.fetchone()[0]
            result3.config(text=f"הלקוח ביצע {count} הזמנות.")
            conn.close()
        except Exception as e:
            messagebox.showerror("שגיאה", str(e))

    tk.Button(window, text="חשב מספר הזמנות", command=run_function).pack()

    #### ---- פרוצדורה: עדכון סטטוס ---- ####
    tk.Label(window, text="\nעדכון סטטוס הזמנה", font=("Arial", 12, "bold")).pack(pady=5)
    frame4 = tk.Frame(window)
    frame4.pack()

    tk.Label(frame4, text="מספר הזמנה:").grid(row=0, column=0)
    order_id_entry = tk.Entry(frame4)
    order_id_entry.grid(row=0, column=1)

    tk.Label(frame4, text="סטטוס חדש:").grid(row=1, column=0)
    new_status_entry = tk.Entry(frame4)
    new_status_entry.grid(row=1, column=1)

    def run_procedure():
        try:
            conn = get_connection()
            cur = conn.cursor()
            cur.execute("CALL update_order_status(%s, %s)", (
                order_id_entry.get(), new_status_entry.get()
            ))
            conn.commit()
            conn.close()
            messagebox.showinfo("הצלחה", "הסטטוס עודכן בהצלחה")
        except Exception as e:
            messagebox.showerror("שגיאה", str(e))

    tk.Button(window, text="עדכן סטטוס", command=run_procedure).pack()
