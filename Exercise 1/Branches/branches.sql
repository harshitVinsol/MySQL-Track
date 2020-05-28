use test;

CREATE TABLE Branch(
	BCode VARCHAR(2) NOT NULL,
    Librarian VARCHAR(20),
    Address VARCHAR(40),
    primary key(BCode)
);

SELECT * FROM Branch;

CREATE TABLE Titles(
	Title VARCHAR(30) NOT NULL,
    Author VARCHAR(20),
    Publisher VARCHAR(20),
    PRIMARY KEY(Title)
);

SELECT * FROM Titles;

CREATE TABLE Holdings(
	Branch VARCHAR(2),
    Title VARCHAR(30),
    `#copies` SMALLINT DEFAULT 1,
    CONSTRAINT PK_Holdings PRIMARY KEY (Branch, Title),
    FOREIGN KEY (Branch) REFERENCES Branch(BCode),
    FOREIGN KEY (Title) REFERENCES Titles(Title)
);

SELECT * FROM Holdings;

INSERT INTO Branch
VALUES('B1', 'John Smith', '2 Anglesea Rd'),
('B2', 'Mary Jones', '32 Pearse St'),
('B3', 'Francis Owens', 'George X');

INSERT INTO Titles
VALUES('Susannah', 'Ann Brown', 'Macmillan'),
('How to Fish', 'Amy Fly', 'Stop Press'),
('A History of Dublin', 'David Little', 'Wiley'),
('Computers', 'Blaise Pascal', 'Applewoods'),
('The Wife', 'Ann Brown', 'Macmillan');

INSERT INTO Holdings 
VALUES ('B1','Susannah',3),
('B1','How to Fish',2),
('B1','A History of Dublin',1),
('B2','How to Fish',4),
('B2','Computers',2),
('B2','The Wife',3),
('B3','A History of Dublin',1),
('B3','Computers',4),
('B3','Susannah',3),
('B3','The Wife',1);

SELECT Title FROM Titles
WHERE Publisher = 'Macmillan';

SELECT DISTINCT Branch FROM Holdings
WHERE Title IN (
  SELECT Title from Titles
  WHERE Author = 'Ann Brown'
);

SELECT DISTINCT Branch FROM Holdings
INNER JOIN Titles ON Titles.Title = Holdings.Title
WHERE Author = 'Ann Brown';

SELECT Branch, SUM(`#copies`) AS Books FROM Holdings
GROUP BY Branch;