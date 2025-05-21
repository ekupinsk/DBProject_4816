CREATE OR REPLACE FUNCTION get_average_order_total(customer_id INT)
RETURNS NUMERIC AS $$
DECLARE
    avg_total NUMERIC;
BEGIN
    SELECT AVG(total_amount)
    INTO avg_total
    FROM Orders
    WHERE Orders.customer_id = customer_id;

    IF avg_total IS NULL THEN
        RETURN 0;
    END IF;

    RETURN avg_total;
END;
$$ LANGUAGE plpgsql;

SELECT get_average_order_total(1);
