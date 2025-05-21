CREATE OR REPLACE FUNCTION log_payment_insert()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO Payment_Log(payment_id, action_time, action)
    VALUES (NEW.payment_id, now(), 'Inserted Payment');
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
-- תחילה צור טבלת לוג
CREATE TABLE IF NOT EXISTS Payment_Log (
    log_id SERIAL PRIMARY KEY,
    payment_id INT,
    action_time TIMESTAMP,
    action TEXT
);
-- ואז צור את הטריגר
CREATE TRIGGER trg_after_payment_insert
AFTER INSERT ON Payment
FOR EACH ROW
EXECUTE FUNCTION log_payment_insert();

INSERT INTO Payment(payment_id, payment_method, payment_status, payment_date, order_id)
VALUES (998, 'Cash', 'Paid', CURRENT_DATE, 1);
SELECT * FROM Payment_Log;
