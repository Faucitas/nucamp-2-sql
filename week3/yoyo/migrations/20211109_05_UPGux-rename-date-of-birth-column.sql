-- rename date_of_birth column
-- depends: 20211109_04_t3sjh-set-default-date-of-birth

ALTER TABLE customers
    RENAME COLUMN date_of_birth TO dob;