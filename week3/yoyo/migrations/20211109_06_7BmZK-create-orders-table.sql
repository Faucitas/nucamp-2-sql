-- create orders table
-- depends: 20211109_05_UPGux-rename-date-of-birth-column

CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    dollar_ammount_spent NUMERIC,
    customer_id INT NOT NULL,
    CONSTRAINT fk_orders_customers
        FOREIGN KEY (customer_id)
        REFERENCES customers(id)
        ON DELETE CASCADE
);