CREATE DATABASE books;

use books;

CREATE TABLE authors(
	id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(20),
    PRIMARY KEY(id)
);

INSERT INTO authors(name)
VALUES('Shakespeare'),
('William Wordsford'),
('Prem Chand');

SELECT * FROM authors;

CREATE TABLE categories(
	id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(20),
    PRIMARY KEY(id)
);

INSERT INTO categories(name)
VALUES('Fiction'),
('Non Fiction'),
('Auto Biography'),
('Thriller'),
('Adventure');

SELECT * FROM categories;

CREATE TABLE articles(
	id INT NOT NULL AUTO_INCREMENT,
    author_id INT NOT NULL,
    category_id INT NOT NULL,
    heading VARCHAR(80),
    content VARCHAR(1000),
    PRIMARY KEY (id),
    FOREIGN KEY (author_id) REFERENCES authors(id),
    FOREIGN KEY (category_id) REFERENCES categories(id)
);

INSERT INTO articles(author_id, category_id, heading, content)
VALUES(1, 2, 'Julies Ceaser', 'This is a long story'),
(2, 3, 'My Life My Rules', 'This is the story of my life'),
(2, 5, 'Indo Pak War', 'This story is about the Indo Pak War of 1999');
INSERT INTO articles(author_id, category_id, heading, content)
VALUES(3, 2, 'Demo Heading', 'Demo Content');

SELECT * FROM articles;

CREATE TABLE users(
	id INT NOT NULL AUTO_INCREMENT,
    type ENUM('Admin', 'Normal') NOT NULL,
    name VARCHAR(20),
    PRIMARY KEY (id)
);

INSERT INTO users(type, name)
VALUES('Admin', 'Harshit'),
('Normal', 'Nitesh'),
('Normal', 'Nitin');

SELECT * FROM Users;

CREATE TABLE comments(
	id INT NOT NULL AUTO_INCREMENT,
    content VARCHAR(200),
    article_id INT,
    user_id INT,
    PRIMARY KEY (id),
    FOREIGN KEY (article_id) REFERENCES articles(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);
    
INSERT INTO comments(content, article_id, user_id)
VALUES('This is a good comment', 1, 1),
('This is a normal comment', 3, 2),
('This is a bad comment',2, 3),
('This is a demo comment', 1, 2);

SELECT * FROM comments;

/*Queries*/
/*Query 1*/
INSERT INTO categories(name)
VALUES('War');

UPDATE categories
SET name = 'Love Stories'
WHERE id = 6; 

DELETE FROM categories
WHERE id = 6;

INSERT INTO articles(author_id, category_id, heading, content)
VALUES(1, 2, 'Android Development', 'This is an article about Android Jetpack');

UPDATE articles
SET Content = 'This is an article about Intents in Android'
WHERE id = 4;

DELETE FROM articles
WHERE id = 4;

INSERT INTO comments(content, article_id, user_id)
VALUES('This is an average comment', 1, 2);

UPDATE comments
SET Content = 'This is a good comment'
WHERE id = 4;

DELETE FROM comments
WHERE id = 4;

INSERT INTO users(type, name)
VALUES('Admin', 'Apoorv');

UPDATE users
SET Type = 'Normal'
WHERE id = 4;

DELETE FROM users
WHERE id = 4;

/*Query 2 Assuming user3 as William Wordsford*/
SELECT * FROM articles
INNER JOIN authors
ON articles.author_id = authors.id
WHERE authors.name = 'William Wordsford';

SET @authorName = 'William Wordsford';
SELECT * FROM articles
INNER JOIN authors
ON articles.author_id = authors.id
WHERE authors.name = @authorName;

/*Query 3*/
SELECT heading, articles.content, comments.content as Comments 
FROM articles
INNER JOIN authors
ON articles.author_id = authors.id
INNER JOIN comments
ON articles.id = comments.article_id
WHERE authors.name = 'William Wordsford';

/* Query 3 using sub query approach */
SELECT articles.heading, articles.content, comments.content
FROM articles, comments
WHERE comments.article_id IN (
	SELECT id FROM articles WHERE author_id = (
		SELECT id FROM authors
		WHERE Name = 'William Wordsford'
	)
)
AND
articles.id = comments.article_id;

/*Query 4*/
SELECT * FROM articles
LEFT JOIN comments
ON comments.article_id = articles.id
WHERE comments.id is NULL;

SELECT * FROM articles
WHERE id NOT IN(
	SELECT article_id FROM comments
);

/*Query 5*/
SELECT articles.id, articles.content, COUNT(comments.content) AS Comment_Count from articles
INNER JOIN comments
ON comments.article_id = articles.id
GROUP BY articles.id
ORDER BY Comment_Count DESC
LIMIT 1;

/*Query 6*/
SELECT articles.id, articles.content FROM articles
LEFT JOIN comments
ON comments.article_id = articles.id
GROUP BY id
HAVING COUNT(comments.content) <= 1;