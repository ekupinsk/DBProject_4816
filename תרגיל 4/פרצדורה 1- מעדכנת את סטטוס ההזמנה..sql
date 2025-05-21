CREATE OR REPLACE PROCEDURE update_order_status(orderId INT, newStatus TEXT)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE Orders
    SET status = newStatus
    WHERE order_id = orderId;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Order ID % not found.', orderId;
    END IF;
END;
$$;

CALL update_order_status(1, 'Completed');
SELECT * FROM Orders WHERE order_id = 1;
