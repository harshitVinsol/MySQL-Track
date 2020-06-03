CREATE DATABASE vtapp;

USE vtapp;

CREATE TABLE users(
	id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(30) NOT NULL,
	designation ENUM('Owner', 'Reviewer', 'Runners', 'Admin') NOT NULL,
    PRIMARY KEY(id)
);

CREATE TABLE tracks(
	id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(30) NOT NULL,
    ownerId INT NOT NULL,
    PRIMARY KEY(id)
);

ALTER TABLE tracks
ADD FOREIGN KEY (ownerId) REFERENCES owners(id);

CREATE TABLE tasks(
	id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(30) NOT NULL,
    trackId INT NOT NULL,
    type ENUM ('exercise_task', 'study_task') NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (trackId) REFERENCES tracks(id)
);

CREATE TABLE assignedTasks(
	id INT NOT NULL AUTO_INCREMENT,
	taskId INT NOT NULL,
    runnerId INT,
    reviewerId INT,
    status ENUM ('Pending', 'Accepted', 'Rejected', 'Submitted') NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY (taskId) REFERENCES tasks(id),
    FOREIGN KEY (runnerId) REFERENCES runners(userId),
    FOREIGN KEY (reviewerId) REFERENCES reviewers(userId)
);

CREATE TABLE remarks(
	id INT NOT NULL AUTO_INCREMENT,
    assignedTaskId INT NOT NULL,
    userId INT NOT NULL,
    content VARCHAR(200),
    PRIMARY KEY (id),
    FOREIGN KEY (assignedTaskId) REFERENCES assignedTasks(id),
    FOREIGN KEY (userId) REFERENCES users(id)
);

CREATE TABLE links(
	id INT NOT NULL AUTO_INCREMENT,
    assignedTaskId INT NOT NULL,
    url VARCHAR(70) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (assignedTaskId) REFERENCES assignedTasks(id)
);

CREATE TABLE owners(
	id INT NOT NULL AUTO_INCREMENT,
	trackId INT NOT NULL,
    userId INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (trackId) REFERENCES tracks(id),
    FOREIGN KEY (userId) REFERENCES users(id)
);

CREATE TABLE reviewers(
	userId INT NOT NULL,
    trackId INT NOT NULL,
    taskId INT NOT NULL,
    CONSTRAINT pk_reviewers PRIMARY KEY(userId, trackId, taskId),
    FOREIGN KEY (userId) REFERENCES users(id),
    FOREIGN KEY (trackId) REFERENCES tracks(id),
    FOREIGN KEY (taskId) REFERENCES tasks(id)
);

CREATE TABLE runners(
	userId INT NOT NULL,
    trackId INT NOT NULL,
    taskId INT NOT NULL,
    CONSTRAINT pk_runners PRIMARY KEY(userId, trackId, taskId),
    FOREIGN KEY (userId) REFERENCES users(id),
    FOREIGN KEY (trackId) REFERENCES tracks(id),
    FOREIGN KEY (taskId) REFERENCES tasks(id)
);
