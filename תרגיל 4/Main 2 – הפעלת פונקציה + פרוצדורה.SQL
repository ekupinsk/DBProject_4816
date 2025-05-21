DO $$
DECLARE
    total_pay NUMERIC;
BEGIN
    total_pay := get_total_payments_by_method('Cash');
    RAISE NOTICE 'Total cash payments: %', total_pay;

    CALL add_dish_to_order(1, 6, 1);
END;
$$;
