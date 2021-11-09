-- drop foreign key contraint from orders
-- depends: 20211109_06_7BmZK-create-orders-table

ALTER TABLE orders
    DROP CONSTRAINT fk_orders_customers;