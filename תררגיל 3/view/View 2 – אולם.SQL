CREATE VIEW hall_event_summary AS
SELECT e.event_id, e.event_date, c.cus_name, h.hall_name, e.total_price
FROM Events e
JOIN Customers c ON e.cus_id = c.cus_id
JOIN Halls h ON e.hall_id = h.hall_id;
SELECT DISTINCT * FROM hall_event_summary