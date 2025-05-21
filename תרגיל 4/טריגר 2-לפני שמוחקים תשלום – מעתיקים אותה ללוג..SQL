CREATE OR REPLACE FUNCTION log_Payment_delete()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO Deleted_Payment(Payment_id, deleted_at)
    VALUES (OLD.Payment_id, now());
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;
-- צור את טבלת הלוג
CREATE TABLE IF NOT EXISTS Deleted_Payment (
    Payment_id INT,
    deleted_at TIMESTAMP
);
-- צור את הטריגר
CREATE TRIGGER trg_before_Payment_delete
BEFORE DELETE ON Payment
FOR EACH ROW
EXECUTE FUNCTION log_Payment_delete();

DELETE FROM Payment WHERE Payment_id = 999;
SELECT * FROM Deleted_Payment;


