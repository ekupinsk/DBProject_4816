CREATE VIEW restaurant_orders_summary AS
SELECT o.order_id, c.full_name, o.order_date,
       SUM(od.quantity * d.price) AS total
FROM Orders o
JOIN Customer c ON o.customer_id = c.customer_id
JOIN Order_Details od ON o.order_id = od.order_id
JOIN Dish d ON od.dish_id = d.dish_id
GROUP BY o.order_id, c.full_name, o.order_date;
SELECT * FROM restaurant_orders_summary