CREATE DATABASE twitter;

USE twitter;

CREATE TABLE relationships (
  id int(11) NOT NULL AUTO_INCREMENT,
  user_id int(11) DEFAULT NULL,
  following_id int(11) DEFAULT NULL,
  PRIMARY KEY (id)
) ENGINE=MyISAM AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;

insert  into relationships(id, user_id, following_id) 
values (1,1,2),(2,1,3),(3,1,5),(4,1,9),(5,1,10),(6,6,7),(7,7,6),(8,5,1),(9,5,2),(10,5,10),(11,9,1),(12,9,2),(13,9,3),(14,9,4),(15,9,5),(16,9,6),(17,9,7),(18,9,8),(19,9,10);

SELECT * FROM relationships;

CREATE TABLE tweets (
  id int(11) NOT NULL AUTO_INCREMENT,
  user_id int(11) DEFAULT NULL,
  content varchar(140) DEFAULT NULL,
  type varchar(100) DEFAULT NULL,
  created_at datetime DEFAULT NULL,
  PRIMARY KEY (id)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;

insert  into tweets ( id, user_id, content, type, created_at) 
values (1,1,'My first ever tweet.',NULL,'2012-08-07 12:52:11'),(2,2,'Test tweet.',NULL,'2012-08-07 12:52:38'),(3,2,'Hello there',NULL,'2012-08-07 12:52:46'),(4,1,'lorem ipsum',NULL,'2012-08-07 12:53:01'),(5,10,'Lets test this...',NULL,'2012-08-07 12:53:18'),(6,5,'I am at vinsol',NULL,'2012-08-07 12:53:59'),(7,9,'Nokis is a nice mobile company',NULL,'2012-08-07 12:54:20'),(8,6,'Its Nokia not Nokis',NULL,'2012-08-07 12:54:36'),(9,9,'Thanks for letting me know',NULL,'2012-08-07 12:54:51'),(10,2,'Stop playing twitter twitter, focus on your job',NULL,'2012-08-07 12:55:46'),(11,7,'Ops.. you caught us',NULL,'2012-08-07 12:57:15'),(12,7,'Btw, what is the score',NULL,'2012-08-07 12:57:27'),(13,1,'Its raining',NULL,'2012-08-07 12:57:43'),(14,4,'really?',NULL,'2012-08-07 12:57:56'),(15,8,'I think we now have enough deta to write queries.',NULL,'2012-08-07 12:58:48');

SELECT * FROM tweets;

CREATE TABLE users (
  id int(11) NOT NULL AUTO_INCREMENT,
  name varchar(255) DEFAULT NULL,
  PRIMARY KEY (id)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

insert  into users( id, name) 
values (1,'Akhil'),(2,'Manik'),(3,'Amit'),(4,'Rahul'),(5,'Kapil'),(6,'John'),(7,'Ryan'),(8,'Sunil'),(9,'Ankur'),(10,'Suman');

/* Query 1 */
SELECT a.name, b.name
FROM users AS a
INNER JOIN relationships
ON a.id = relationships.user_id
INNER JOIN users AS b
ON b.id = relationships.following_id;

/* Query 2 */
SELECT a.name, GROUP_CONCAT(DISTINCT b.name) as followings
FROM users As a
INNER JOIN relationships
ON a.id = relationships.user_id
INNER JOIN users AS b
ON b.id = relationships.following_id
GROUP BY a.name
ORDER BY(COUNT(following_id)) DESC;

/* Query 3 */
SELECT name, content, created_at
FROM users
INNER JOIN tweets
ON tweets.user_id = users.id
WHERE users.id = 1
UNION
SELECT b.name, content, created_at
FROM users AS a
INNER JOIN relationships
ON a.id = relationships.user_id
INNER JOIN users AS b
ON b.id = relationships.following_id
INNER JOIN tweets
ON b.id = tweets.user_id
WHERE a.id = 1
ORDER by created_at DESC;

/* Query 4 */
SELECT name, COUNT(content) as total_tweets
FROM users
LEFT JOIN tweets  /* used LEFT JOIN if the user has an account but did not tweet. */
ON users.id = tweets.user_id
GROUP BY name;

/* Query 5 */
SELECT name
FROM users
LEFT JOIN tweets
ON users.id = tweets.user_id
GROUP BY name
HAVING COUNT(content) = 0;

/* Query 6 */
SELECT users.name, tweets.content
FROM tweets
INNER JOIN users
ON users.id = tweets.user_id
WHERE created_at >= DATE_SUB(NOW(),INTERVAL 1 HOUR);

