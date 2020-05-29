use test;

CREATE TABLE Authors(
	id VARCHAR(4) NOT NULL,
    Name VARCHAR(20),
    PRIMARY KEY(id)
);

INSERT INTO Authors
VALUES('1', 'Shakespeare'),
('2', 'William Wordsford'),
('3', 'Prem Chand');

SELECT * FROM Authors;

CREATE TABLE Categories(
	id VARCHAR(4) NOT NULL,
    Name VARCHAR(20),
    PRIMARY KEY(id)
);

INSERT INTO Categories
VALUES('1', 'Fiction'),
('2', 'Non Fiction'),
('3', 'Auto Biography'),
('4', 'Thriller'),
('5', 'Adventure');

SELECT * FROM Categories;

CREATE TABLE Articles(
	id VARCHAR(4) NOT NULL,
    AuthorId VARCHAR(4) NOT NULL,
    CategoryId VARCHAR(4) NOT NULL,
    Heading VARCHAR(80),
    Content VARCHAR(1000),
    PRIMARY KEY (id),
    FOREIGN KEY (AuthorId) REFERENCES Authors(id),
    FOREIGN KEY (CategoryId) REFERENCES Categories(id)
);

INSERT INTO Articles
VALUES('1', '1', '2', 'Julies Ceaser', 'This is a long story'),
('2', '2', '3', 'My Life My Rules', 'This is the story of my life'),
('3','2','5', 'Indo Pak War', 'This story is about the Indo Pak War of 1999');
INSERT INTO Articles
VALUES('4','3', '2', 'Demo Heading', 'Demo Content');

SELECT * FROM Articles;

CREATE TABLE Users(
	id VARCHAR(4) NOT NULL,
    Type ENUM('Admin', 'Normal') NOT NULL,
    Name VARCHAR(20),
    PRIMARY KEY (id)
);

INSERT INTO Users
VALUES('1', 'Admin', 'Harshit'),
('2', 'Normal', 'Nitesh'),
('3', 'Normal', 'Nitin');

SELECT * FROM Users;

CREATE TABLE Comments(
	id VARCHAR(4) NOT NULL,
    Content VARCHAR(200),
    ArticleId VARCHAR(4),
    UserId VARCHAR(4),
    PRIMARY KEY (id),
    FOREIGN KEY (ArticleId) REFERENCES Articles(id),
    FOREIGN KEY (UserId) REFERENCES Users(id)
);
    
INSERT INTO Comments
VALUES('1', 'This is a good comment', '1', '1'),
('2', 'This is a normal comment', '3', '2'),
('3', 'This is a bad comment','2', '3'),
('4', 'This is a demo comment', '1', '2');

SELECT * FROM Comments;

/*Queries*/
/*Query 1*/
INSERT INTO Categories
VALUES('6', 'War');

UPDATE Categories
SET Name = 'Love Stories'
WHERE id = '6'; 

DELETE FROM Categories
WHERE id = '6';

INSERT INTO Articles
VALUES('4', '1', '2', 'Android Development', 'This is an article about Android Jetpack');

UPDATE Articles
SET Content = 'This is an article about Intents in Android'
WHERE id = '4';

DELETE FROM Articles
WHERE id = '4';

INSERT INTO Comments
VALUES('5', 'This is an average comment', '1', '2');

UPDATE Comments
SET Content = 'This is a good comment'
WHERE id = '4';

DELETE FROM Comments
WHERE id = '4';

INSERT INTO Users
VALUES('4', 'Admin', 'Apoorv');

UPDATE Users
SET Type = 'Normal'
WHERE id = '4';

DELETE FROM Users
WHERE id = '4';

/*Query 2 Assuming user3 as William Wordsford*/
SELECT * FROM Articles
INNER JOIN Authors
ON Articles.AuthorId = Authors.id
WHERE Authors.Name = 'William Wordsford';

SET @authorName = 'William Wordsford';
SELECT * FROM Articles
INNER JOIN Authors
ON Articles.AuthorId = Authors.id
WHERE Authors.Name = @authorName;

/*Query 3*/
SELECT Heading, Articles.Content, Comments.Content as Comments FROM Articles
INNER JOIN Authors
ON Articles.AuthorId = Authors.id
INNER JOIN Comments
ON Articles.id = Comments.ArticleId
WHERE Authors.Name = 'William Wordsford';

/*Query 4*/
SELECT * FROM Articles
LEFT JOIN Comments
ON Comments.ArticleId = Articles.id
WHERE Comments.id is NULL;

SELECT * FROM Articles
WHERE id NOT IN(
	SELECT ArticleId FROM Comments
);

/*Query 5*/
SELECT * FROM (
SELECT Articles.id, Articles.Content, COUNT(Comments.Content) AS comment_count from Articles
INNER JOIN Comments
ON Comments.ArticleId = Articles.id
GROUP BY Articles.id)combined_blog
ORDER BY comment_count DESC
LIMIT 1;

/*Query 6*/
SELECT Articles.id, Articles.Content FROM Articles
LEFT JOIN Comments
ON Comments.ArticleId = Articles.id
GROUP BY id
HAVING COUNT(Comments.Content) <= 1;