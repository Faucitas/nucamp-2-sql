-- kill other connections
SELECT pg_terminate_backend(pg_stat_activity.pid)
FROM pg_stat_activity
WHERE pg_stat_activity.datname = 'week1_workshop' AND pid <> pg_backend_pid();
-- (re)create the database
DROP DATABASE IF EXISTS week1_workshop;
CREATE DATABASE week1_workshop;
-- connect via psql
\c week1_workshop

-- database configuration
SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET default_tablespace = '';
SET default_with_oids = false;


---
--- CREATE tables
---

CREATE TABLE products (
    id SERIAL,
    name TEXT NOT NULL,
    discontinued BOOLEAN NOT NULL,
    supplier_id INT,
    category_id INT,
    PRIMARY KEY(id)
);

CREATE TABLE categories (
    id SERIAL,
    name TEXT UNIQUE NOT NULL,
    description TEXT,
    picture TEXT,
    PRIMARY KEY (id)
);

-- TODO create more tables here...
CREATE TABLE suppliers (
    supplier_id SERIAL,
    name TEXT NOT NULL,
    PRIMARY KEY (supplier_id)
);

CREATE TABLE customers (
    id SERIAL,
    name TEXT NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE employees (
    id SERIAL,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    reports_to INT,
    PRIMARY KEY (id)
);

CREATE TABLE orders (
    id SERIAL,
    order_date DATE,
    customer_id INT NOT NULL,
    employee_id INT,
    PRIMARY KEY(id) 
);

CREATE TABLE orders_products (
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    discount NUMERIC NOT NULL,
    PRIMARY KEY (order_id, product_id)
);

CREATE TABLE territories (
    id SERIAL,
    description TEXT NOT NULL,
    PRIMARY KEY(id)
);

CREATE TABLE employees_territories(
    employee_id INT,
    territory_id INT,
    PRIMARY KEY (employee_id, territory_id)
);

CREATE TABLE officies (
    id SERIAL,
    address_line TEXT,
    territory_id INT NOT NULL UNIQUE,
    PRIMARY KEY(id)
);

CREATE TABLE us_states (
    id SERIAL,
    name CHARACTER(2) NOT NULL UNIQUE,
    abbreviation TEXT NOT NULL UNIQUE,
    PRIMARY KEY(id)
);

---
--- Add foreign key constraints
---
ALTER TABLE products
ADD CONSTRAINT fk_products_categories 
FOREIGN KEY (category_id) 
REFERENCES categories;

-- TODO create more constraints here...
ALTER TABLE products
ADD CONSTRAINT fk_products_suppliers 
FOREIGN KEY (supplier_id) 
REFERENCES suppliers;

ALTER TABLE employees
ADD CONSTRAINT fk_employee_reports_to
FOREIGN KEY (reports_to)
REFERENCES employees;

ALTER TABLE orders
ADD CONSTRAINT fk_orders_customers
FOREIGN KEY (customer_id)
REFERENCES customers;

ALTER TABLE orders
ADD CONSTRAINT fk_orders_employees
FOREIGN KEY (employee_id)
REFERENCES employees;

ALTER TABLE orders_products
ADD CONSTRAINT fk_orders_products_orders
FOREIGN KEY (order_id)
REFERENCES orders;

ALTER TABLE orders_products
ADD CONSTRAINT fk_orders_products_producs
FOREIGN KEY (product_id)
REFERENCES products;

ALTER TABLE employees_territories
ADD CONSTRAINT fk_employees_terretories_employees
FOREIGN KEY (employee_id)
REFERENCES employees;

ALTER TABLE employees_territories
ADD CONSTRAINT fk_employees_terretories_territories
FOREIGN KEY (territory_id)
REFERENCES territories;

ALTER TABLE officies
ADD CONSTRAINT fk_officies_territories
FOREIGN KEY (territory_id)
REFERENCES territories;
