-- set default date_of_birth
-- depends: 20211109_03_DttMQ-set-not-null-date-of-birth

ALTER TABLE customers
    ALTER COLUMN date_of_birth SET DEFAULT now();