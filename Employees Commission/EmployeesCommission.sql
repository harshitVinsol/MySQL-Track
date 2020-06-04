CREATE DATABASE new_commission;

USE new_commission;

CREATE TABLE departments(
	id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(20) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE employees(
	id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(30) NOT NULL,
    salary INT,
    departmentId INT,
    PRIMARY KEY (id),
    FOREIGN KEY (departmentId) REFERENCES departments(id)
);

CREATE TABLE commissions(
	id INT NOT NULL AUTO_INCREMENT,
    employeeId INT NOT NULL,
    commission_amount INT,
    PRIMARY KEY (id),
    FOREIGN KEY (employeeId) REFERENCES employees(id)
);

INSERT INTO departments(name)
VALUES('Banking'),
('Insurance'),
('Services');

SELECT * FROM departments;

INSERT INTO employees(name, salary, departmentId)
VALUES('Chris Gayle', 1000000, 1),
('Michael Clark', 800000, 2),
('Rahul Dravid', 700000, 1),
('Ricky Ponting', 600000, 2),
('Albie Morkel', 650000, 2),
('Wasim Akram', 750000, 3);

SELECT * FROM employees;

INSERT INTO commissions(employeeId, commission_amount)
VALUES(1, 5000),
(2, 3000),
(3, 4000),
(1, 4000),
(2, 3000),
(4, 2000),
(5, 1000),
(6, 5000);

SELECT * FROM commissions;

/*Queries*/
/* 1 */
EXPLAIN SELECT employees.name,SUM(commission_amount) AS total_commision FROM employees
INNER JOIN commissions
ON employees.id = commissions.employeeId
GROUP BY employees.id
ORDER BY total_commision DESC
LIMIT 1;

/* 2 */
SELECT name, salary FROM employees
ORDER BY salary DESC
LIMIT 3,1;

/* 3 */
SELECT departments.id, departments.name, SUM(commissions.commission_amount) AS Total_Commission_Amount 
FROM departments
INNER JOIN employees
ON departments.id = employees.DepartmentId
INNER JOIN commissions
ON commissions.employeeId = employees.id
GROUP BY departmentId
ORDER BY Total_Commission_Amount DESC
LIMIT 1;

/* Updated Query 4 */
SELECT GROUP_CONCAT(DISTINCT name) AS Employee_Name, commission_amount AS Commission 
FROM commissions
INNER JOIN employees
ON employees.id = commissions.employeeId
GROUP BY commission_amount
HAVING commission_amount > 3000;

/* Indexing */
ALTER TABLE commissions
ADD INDEX index_commission (commission_amount);

ALTER TABLE employees
ADD INDEX index_employees (salary);

ALTER TABLE commissions
DROP INDEX index_commission;

ALTER TABLE employees
DROP INDEX index_employees;
