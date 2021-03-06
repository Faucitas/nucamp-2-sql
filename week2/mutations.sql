-- Part 4: Mutations

-- Management has decided it would like to designate employees as experts of 
-- zero or more categories, and they want the database to keep track of who is
-- an expert in what. 
-- Q: How will you satisfy this new requirement? 
-- A: Add a foreign key to the employess table and create a employee_categories table
-- Q: What type of relationship is this? (e.g. 1-1, 1-many, or many-to-many?)
-- A: one to many 
-- Feel free to fill in the blanks above with a comment or two.



-- 4.1: Create table
-- Write a SQL statement that creates a new table meeting the following criteria:
--   1. It is named employees_categories
--   2. It has a employee_id column of type INTEGER
--   3. It has a category_id column of type INTEGER
--   4. Its primary key is a tuple of (employee_id, category_id) pairs

CREATE TABLE employee_categories (
    employee_id INT,
    category_id INT,
    PRIMARY KEY (employee_id, category_id)
);


-- 4.2: Alter table
-- Make the employee_id column of employees_categories reference the 
-- primary key column of employees.

ALTER TABLE employee_categories
ADD CONSTRAINT fk_employee_categories_employee
FOREIGN KEY (employee_id)
REFERENCES employees;

-- 4.3: Alter table
-- Make the category_id column of employees_categories reference the 
-- primary key column of categories.

ALTER TABLE employee_categories
ADD CONSTRAINT fk_employee_categories_categories
FOREIGN KEY (category_id)
REFERENCES categories;

-- 4.4: Insert records
-- Write a query that inserts the following employee ID, category ID pairs 
-- into employees_categories:
-- (1,2), (3,4), (4,3), (4,4), (8,2), (1,8), (1,3), (1,6)

INSERT INTO employee_categories (employee_id, category_id)
VALUES (1,2), (3,4), (4,3), (4,4), (8,2), (1,8), (1,3), (1,6);


-- 4.5: Remove records
-- Write query that deletes all rows from employees_categories but does not 
-- delete the employees_categories table itself.
DELETE FROM employee_categories;

-- Bonus: Refer to the new management decision at the top of this file.  
-- Write a query that assigns all employees of the London office to be 
-- experts in the Dairy Products category.

-- 4.6: Delete table
-- Write a query to delete the employees_categories table
DROP TABLE employee_categories;