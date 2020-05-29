CREATE DATABASE transactions;

use transactions;

CREATE TABLE Accounts(
	id VARCHAR(4) NOT NULL,
    AccountNo VARCHAR(8) NOT NULL,
    Balance DECIMAL(12,2) DEFAULT NULL,
    PRIMARY KEY(AccountNo)
);

CREATE TABLE Users(
	id VARCHAR(4) NOT NULL,
    Name VARCHAR(30) NOT NULL,
    Email VARCHAR(30),
    AccountNo VARCHAR(8) NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY (AccountNo) REFERENCES Accounts(AccountNo)
);

INSERT INTO Accounts
VALUES('1', 'A100', 2400.00),
('2', 'A101', 3750.50),
('3', 'A102', 2875.00);

SELECT * FROM Accounts;

INSERT INTO Users
VALUES('1', 'Harshit Singh', 'harshit@vinsol.com', 'A100'),
('2', 'Nitin Kumar', 'nitin@gmail.com', 'A101'),
('3', 'Ayushi Dixit', 'aayushhi@yahoo.in', 'A102');

SELECT * FROM Users;

/*Queries*/

START TRANSACTION;

UPDATE Accounts
INNER JOIN Users
ON Users.AccountNo = Accounts.AccountNo
SET Balance = Balance + 1000
WHERE Users.Name = 'Harshit Singh'; 

UPDATE Accounts
INNER JOIN Users
ON Users.AccountNo = Accounts.AccountNo
SET Balance = Balance - 500
WHERE Users.Name = 'Harshit Singh'; 

SELECT * FROM Accounts;

UPDATE Accounts
INNER JOIN Users
ON Users.AccountNo = Accounts.AccountNo
SET Balance = Balance - 200
WHERE Users.Name = 'Harshit Singh'; 

UPDATE Accounts
INNER JOIN Users
ON Users.AccountNo = Accounts.AccountNo
SET Balance = Balance + 200
WHERE Users.Name = 'Nitin Kumar'; 

COMMIT;

 

    