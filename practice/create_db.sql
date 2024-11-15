CREATE DATABASE College;

Use College;

CREATE TABLE student(
	rollno INT PRIMARY KEY,
    name VARCHAR(50)
);

SElect * from student;

INSERT INTO student(rollno,name)
Values
(101,"Shawon"),
(102,"Auwal");

INSERT INTO student VALUES(103,"Sumon");