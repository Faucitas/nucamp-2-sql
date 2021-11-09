-- set NOT NULL date_of_birth
-- depends: 20211109_02_PdYFy-customers-date-of-birth

ALTER TABLE customers
    ALTER COLUMN date_of_birth DROP NOT NULL;