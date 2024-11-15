create database college_join;

use college_join;

create table student(
	student_id int primary key,
    name varchar(50)
);

create table course(
	id int primary key,
    course varchar(50)
);

insert into student(student_id,name)
values
(101,"Adam"),
(102,"bob"),
(103,"casey");

insert into course(id,course)
values
(102,"english"),
(105,"math"),
(103,"science"),
(107,"computer science");

select * from student;
select * from course;

SELECT * 
FROM student
INNER JOIN course
ON student.student_id = course.id;

select * 
from student as a 
left join course as b
On a.student_id = b.id;

select * 
from student as a 
right join course as b
On a.student_id = b.id;

select * 
from student as a 
left join course as b
On a.student_id = b.id
UNION
select * 
from student as a 
right join course as b
On a.student_id = b.id;