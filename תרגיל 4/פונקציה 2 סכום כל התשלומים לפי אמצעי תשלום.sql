CREATE OR REPLACE FUNCTION get_total_payments_by_method(method TEXT)
RETURNS NUMERIC AS $$
DECLARE
    total NUMERIC := 0;
BEGIN
    SELECT SUM(O.total_amount)
    INTO total
    FROM Payment P
    JOIN Orders O ON O.order_id = P.order_id
    WHERE P.payment_method = method;

    RETURN COALESCE(total, 0);
END;
$$ LANGUAGE plpgsql;

SELECT get_total_payments_by_method('Cash');
