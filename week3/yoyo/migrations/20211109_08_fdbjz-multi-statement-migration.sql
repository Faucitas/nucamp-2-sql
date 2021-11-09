-- multi-statement migration
-- depends: 20211109_07_bNPDb-drop-foreign-key-contraint-from-orders

CREATE TABLE table_1 (id SERIAL PRIMARY KEY);
CREATE TABLE table_2 (id SERIAL PRIMARY KEY);
CREATE TABLE table_3 (id SERIAL PRIMARY KEY);