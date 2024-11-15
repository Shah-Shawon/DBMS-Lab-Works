use college;

Alter table student
change name full_name varchar(50);

select * from student;

delete from student
where marks<80;

Alter table student
drop column grade;