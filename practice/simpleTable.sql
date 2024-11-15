CREATE DATABASE college;

use college;

create table student(
	rollno int primary key,
    name varchar(50),
    marks int not null,
    grade varchar(2),
    city varchar(20)
);

INSERT into student(rollno,name,marks,grade,city)
Values
(101,"Shawon",78,"A","Cumilla"),
(102,"Nazma",99,"A+","Dhaka"),
(103,"Kowser",78,"A","Cumilla"),
(104,"Pinky",99,"A+","Dhaka"),
(105,"Minhaz",78,"A","Cumilla"),
(106,"Shohan",99,"A+","Dhaka"),
(107,"Rejma",95,"A+","Sirajganj");

truncate table student;

select name,marks from student;

select * from student;

SELECT *
FROM student
WHERE marks>80
LIMIT 3;

SELECT *
FROM student
order by marks asc;

SET SQl_safe_updates = 0;

UPDATE student
SET grade = "O"
where grade = "A+";

UPDATE student 
SET marks = marks+1;

ALTER TABLE student
add column age int default 19;

alter table student
drop column age;
