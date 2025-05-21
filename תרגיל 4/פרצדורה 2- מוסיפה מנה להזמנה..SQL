CREATE OR REPLACE PROCEDURE add_dish_to_order(orderId INT, dishId INT, quantity INT)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO Order_Details(order_id, dish_id, quantity, note)
    VALUES (orderId, dishId, quantity, '');

    UPDATE Orders
    SET total_amount = total_amount + (
        SELECT price * quantity FROM Dish WHERE dish_id = dishId
    )
    WHERE order_id = orderId;
END;
$$;

CALL add_dish_to_order(1, 4, 2);
SELECT * FROM Orders WHERE order_id = 1;
