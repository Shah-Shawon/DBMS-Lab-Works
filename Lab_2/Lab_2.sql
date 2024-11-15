CREATE DATABASE Lab_2;

use Lab_2;

create table employee (
	employee_name varchar(50) primary key,
	street varchar(50),
	city varchar(50)
);
drop table employee;
create table works (
	employee_name varchar(50), 
    company_name varchar(50), 
    salary int,
    foreign key (employee_name) references employee(employee_name)
);
drop table works;

INSERT INTO employee (employee_name, street, city)
VALUES
    ('Arif', '51 upashahar', 'Rajshahi'),
    ('Sumon', '52 east', 'Moynamati'),
    ('Sagor', 'Neemgachhi', 'Sirajgong'),
    ('Abdul', 'Binodpur', 'Rajshahi'),
    ('Himesh', 'Nazrul avenue', 'Dhaka'),
    ('Amirul', 'Chawk bazar', 'Sylhet'),
    ('Sajib', '99 north', 'Chittagong');

INSERT INTO works (employee_name, company_name, salary)
VALUES
    ('Sumon', 'Agrani', 12000),
    ('Abdul', 'Sonali', 13000),
    ('Himesh', 'Agrani', 6000),
    ('Amirul', 'Sonali', 20000),
	('Sagor', 'Sonali', 8000),
    ('Arif', 'Janata', 13000),
    ('Sajib', 'Janata', 9000);

Select employee_name from employee
where city ='Rajshahi';

Select employee_name,street from employee
where city ='Rajshahi';

SELECT DISTINCT employee_name,company_name
FROM works
WHERE company_name IN ('Sonali', 'Agrani', 'Janata');

SELECT DISTINCT employee_name,salary
FROM works
WHERE company_name IN ('Sonali', 'Agrani', 'Janata');

SELECT DISTINCT employee_name,salary
FROM works
WHERE salary = 12000 ;

SELECT DISTINCT employee_name,salary
FROM works
WHERE salary >= 12000;

SELECT DISTINCT employee_name,company_name
FROM works
WHERE  salary <=12000;

SELECT DISTINCT employee_name,company_name
FROM works
WHERE salary = 12000 ;

SELECT DISTINCT employee_name,salary
FROM works
WHERE salary >= 12000;

SELECT DISTINCT employee_name,company_name
FROM works
WHERE  salary <=12000;

Select e.employee_name,e.street,e.city
from employee as e
join works as w
on e.employee_name = w.employee_name
where w.company_name = 'Agrani';

Select e.employee_name,e.street,e.city
from employee as e
join works as w
on e.employee_name = w.employee_name
where w.salary >= 10000;

Select e.employee_name,w.company_name,e.street,e.city
from employee as e
join works as w
on e.employee_name = w.employee_name
where w.salary >= 10000;

Select e.employee_name,e.street,e.city
from employee as e
join works as w
on e.employee_name = w.employee_name
where w.company_name = 'Sonali' and w.salary >= 12000;

select employee_name from works
where company_name != 'Sonali';

update employee
set city = 'natore'
where employee_name = 'Arif';

set sql_safe_updates = 0;

update works
set salary = salary + (salary*0.10)
where company_name = 'Agrani';

select * from works;

delete from works
where employee_name = 'Sagor';

delete from employee
where employee_name = 'Sagor';

Alter table works
add column manager varchar(50);