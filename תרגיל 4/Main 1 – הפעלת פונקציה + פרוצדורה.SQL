DO $$
DECLARE
    avg_amount NUMERIC;
BEGIN
    avg_amount := get_average_order_total(1);
    RAISE NOTICE 'Average order total: %', avg_amount;

    CALL update_order_status(1, 'Completed');
END;
$$;
