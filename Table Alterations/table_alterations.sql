use test;

CREATE TABLE testing_table(
	name VARCHAR(30),
    contact_name VARCHAR(30),
    roll_no VARCHAR(30)
)

/*SELECT * FROM testing_table;*/

ALTER TABLE testing_table
DROP COLUMN name;

ALTER TABLE testing_table
RENAME COLUMN contact_name TO username;

ALTER TABLE testing_table
ADD COLUMN first_name VARCHAR(30) FIRST;

ALTER TABLE testing_table
ADD COLUMN last_name VARCHAR(30) AFTER first_name;

ALTER TABLE testing_table
MODIFY roll_no INT;