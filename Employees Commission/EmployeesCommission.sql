CREATE DATABASE commission;

USE commission;

CREATE TABLE Departments(
	id VARCHAR(2) NOT NULL,
    Name VARCHAR(20) NOT NULL,
    PRIMARY KEY (id)
);

INSERT INTO Departments
VALUES('1', 'Banking'),
('2', 'Insurance'),
('3', 'Services');

SELECT * FROM Departments;

CREATE TABLE Employees(
	id VARCHAR(2) NOT NULL,
    Name VARCHAR(30) NOT NULL,
    Salary INT,
    DepartmentId VARCHAR(2),
    PRIMARY KEY (id),
    FOREIGN KEY (DepartmentId) REFERENCES Departments(id)
);

INSERT INTO Employees
VALUES('1', 'Chris Gayle', 1000000, '1'),
('2', 'Michael Clark', 800000, '2'),
('3', 'Rahul Dravid', 700000, '1'),
('4', 'Ricky Ponting', 600000, '2'),
('5', 'Albie Morkel', 650000, '2'),
('6', 'Wasim Akram', 750000, '3');

SELECT * FROM Employees;

CREATE TABLE Commissions(
	id VARCHAR(2) NOT NULL,
    EmployeeId VARCHAR(2) NOT NULL,
    Commission_Amount INT,
    PRIMARY KEY (id),
    FOREIGN KEY (EmployeeId) REFERENCES Employees(id)
);

INSERT INTO Commissions
VALUES('1', '1', 5000),
('2', '2', 3000),
('3', '3', 4000),
('4', '1', 4000),
('5', '2', 3000),
('6', '4', 2000),
('7', '5', 1000),
('8', '6', 5000);

SELECT * FROM Commissions;

ALTER TABLE Employees
MODIFY DepartmentId VARCHAR(2) NOT NULL;

/*Queries*/

SELECT Employees.Name,SUM(Commission_Amount) AS total_commision FROM Employees
INNER JOIN Commissions
ON Employees.id = Commissions.EmployeeId
GROUP BY Employees.id
ORDER BY total_commision DESC
LIMIT 1;

SELECT Name, Salary FROM Employees
ORDER BY Salary DESC
LIMIT 3,1;

SELECT Departments.id, Departments.Name, SUM(Commissions.Commission_Amount) AS Total_Commission_Amount FROM Departments
INNER JOIN Employees
ON Departments.id = Employees.DepartmentId
INNER JOIN Commissions
ON Commissions.EmployeeId = Employees.id
GROUP BY DepartmentId
ORDER BY Total_Commission_Amount DESC
LIMIT 1;

SELECT GROUP_CONCAT(Name,' ',Total_Commision) AS "Commission > 3000" FROM (
SELECT Employees.Name,SUM(commission_amount) AS total_commision from Employees
INNER JOIN Commissions
ON Commissions.EmployeeId = Employees.id
GROUP BY EmployeeId
HAVING total_commision > 3000) combined;