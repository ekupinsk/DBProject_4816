-- אילוץ NOT NULL
ALTER TABLE Customer
ALTER COLUMN full_name SET NOT NULL;

-- אילוץ CHECK
ALTER TABLE Dish DROP CONSTRAINT IF EXISTS chk_price_positive;
ALTER TABLE Dish ADD CONSTRAINT chk_price_positive CHECK (price >= 0);


-- אילוץ DEFAULT
ALTER TABLE Restaurant_Table
ALTER COLUMN is_available SET DEFAULT 'Y';