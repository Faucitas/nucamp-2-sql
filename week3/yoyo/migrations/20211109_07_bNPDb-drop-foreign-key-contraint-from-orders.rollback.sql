-- drop foreign key contraint from orders
-- depends: 20211109_06_7BmZK-create-orders-table

ALTER TABLE orders
ADD CONSTRAINT fk_orders_customers
FOREIGN KEY (customer_id)
REFERENCES customers(id)
ON DELETE CASCADE;