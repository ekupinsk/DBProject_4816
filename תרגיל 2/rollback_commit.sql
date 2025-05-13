-- עדכון זמני עם ROLLBACK
BEGIN;
UPDATE Dish SET price = price * 1.2;
SELECT * FROM Dish;
ROLLBACK;
SELECT * FROM Dish;

-- עדכון עם COMMIT
BEGIN;
UPDATE Dish SET price = price * 0.9;
SELECT * FROM Dish;
COMMIT;
SELECT * FROM Dish;