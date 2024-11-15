Create database XYZ;

USE XYZ;

CREATE TABLE info(
id int primary key,
name varchar(50),
salary float
);

INSERT INTO info (id,name,salary)
VALUES
(1,"Adam",25000),
(2,"Bob" , 30000),
(3,"Casey" , 40000);

SELECT * FROM info;