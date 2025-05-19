FROM Customer_Link cl
JOIN Customer c ON cl.customer_id = c.customer_id
JOIN Customers cu ON cl.cus_id = cu.cus_id
LEFT JOIN Events e ON cu.cus_id = e.cus_id
LEFT JOIN Orders o ON c.customer_id = o.customer_id;
SELECT DISTINCT *
FROM linked_customers_events_orders