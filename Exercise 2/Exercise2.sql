CREATE DATABASE vtapp;

CREATE USER 'vtapp_user'@'localhost' IDENTIFIED BY 'harshit123';

GRANT SELECT ON vtapp . * TO 'vtapp_user'@'localhost';

FLUSH PRIVILEGES
