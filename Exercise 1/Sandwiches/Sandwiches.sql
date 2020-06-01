use test;

CREATE TABLE Tastes(
	Name VARCHAR(20) NOT NULL,
    Filling VARCHAR(20) NOT NULL,
    CONSTRAINT PK_Tastes PRIMARY KEY(Name, Filling)
);

CREATE TABLE Locations(
	LName VARCHAR(20) NOT NULL,
    Phone INT(7),
    Address VARCHAR(30),
    PRIMARY KEY (LName)
);
    
CREATE TABLE Sandwiches(
	Location VARCHAR(20),
    Bread VARCHAR(10),
    Filling VARCHAR(20),
    Price FLOAT,
    CONSTRAINT PK_Sandwiches PRIMARY KEY(Location, Bread, Filling),
    FOREIGN KEY (Location) REFERENCES Locations(LName)
);

INSERT INTO Tastes
VALUES('Brown', 'Turkey'),
('Brown', 'Beef'),
('Brown', 'Ham'),
('Jones', 'Cheese'),
('Green', 'Beef'),
('Green', 'Turkey'),
('Green', 'Cheese');

SELECT * FROM Tastes;

INSERT INTO Locations
VALUES('Lincoln', 6834523, 'Lincoln Place'),
("O'Neill's", 6742134, 'Pearse St'),
('Old Nag', 7678132, 'Dame St'),
('Buttery', 7023421, 'College St');

SELECT * FROM Locations;

INSERT INTO Sandwiches
VALUES('Lincoln', 'Rye', 'Ham', 1.25),
("O'Neill's", 'White', 'Cheese', 1.20),
("O'Neill's", 'Whole', 'Ham', 1.25),
('Old Nag', 'Rye', 'Beef', 1.35),
('Buttery', 'White', 'Cheese', 1.00),
("O'Neill's", 'White', 'Turkey', 1.35),
('Buttery', 'White', 'Ham', 1.10),
('Lincoln', 'Rye', 'Beef', 1.35),
('Lincoln', 'White', 'Ham', 1.30),
('Old Nag', 'Rye', 'Ham', 1.40);

SELECT * FROM Sandwiches;

SELECT * FROM Locations
WHERE LName IN (
	SELECT Location FROM Sandwiches
	WHERE Filling IN(
		SELECT Filling FROM Tastes
		WHERE Name = 'Jones'
	)
);

SELECT LName, Phone, Address from Locations
INNER JOIN Sandwiches
ON Sandwiches.location = Locations.lname
INNER JOIN Tastes
ON Sandwiches.filling = Tastes.filling
WHERE Tastes.Name = 'Jones';

SELECT Location, COUNT(DISTINCT Name) AS "NUMBER OF PEOPLE" from Tastes
INNER JOIN Sandwiches
ON Sandwiches.Filling = Tastes.Filling
GROUP BY Location;

/*Making Phone a VARCHAR*/
ALTER TABLE Locations
MODIFY Phone VARCHAR(10);

/*for each location the number of people who can eat there*/
INSERT INTO Locations
VALUES('Delhi', '999999', 'Hauz Khas');

SELECT Locations.LName, COUNT(DISTINCT Tastes.Name) AS Number_Of_People FROM Sandwiches
RIGHT JOIN Locations
ON Sandwiches.location = Locations.lname
LEFT JOIN Tastes
ON Sandwiches.filling = Tastes.filling
GROUP BY Locations.LName
ORDER BY Number_Of_People;