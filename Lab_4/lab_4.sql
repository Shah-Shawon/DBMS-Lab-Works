create database lab_4;
use lab_4;
create table employee(
	employee_name varchar(50) primary key,
    street varchar(50),
    city varchar(50)
);

create table company(
	company_name  varchar(50) primary key,
    city varchar(50)
);

create table works(
	employee_name varchar(50) primary key,
    company_name varchar(50), 
    salary int,
    foreign key(employee_name) references employee(employee_name),
    foreign key(company_name) references company(company_name)
);

create table manages(
	employee_name varchar(50) primary key, 
	manager_name varchar(50),
	foreign key(employee_name) references employee(employee_name)
);
    
insert into employee(employee_name,street,city) values
	('Arif','51 upashahar','Rajshahi'),
    ('Sumon','52 east', 'Moynamati'),
    ('Sagor', 'Neemgachhi', 'Sirajgong'),
('Abdul', 'Binodpur', 'Rajshahi'),
('Himesh', 'Nazrul avenue', 'Dhaka'),
('Amirul', 'Chawk bazar', 'Sylhet'),
('Sajib', '99 north', 'Chittagong');
select * from employee;

INSERT INTO company (company_name, city) VALUES
('Agrani', 'Rajshahi'),
('Sonali', 'Sylhet'),
('Janata', 'Dhaka');


INSERT INTO works (employee_name, company_name, salary) VALUES
('Sumon', 'Agrani', 12000),
('Abdul', 'Sonali', 13000),
('Himesh', 'Agrani', 6000),
('Amirul', 'Sonali', 20000),
('Sagor', 'Sonali', 8000),
('Arif', 'Janata', 13000),
('Sajib', 'Janata', 9000);

INSERT INTO manages (employee_name, manager_name) VALUES
('Amirul', 'Amirul'),
('Abdul', 'Amirul'),
('Sagor', 'Amirul'),
('Sumon','Sumon'),
('Himesh', 'Sumon'),
('Arif', 'Arif'),
('Sajib', 'Arif');

select employee_name from works
where company_name = 'Sonali';

select e.employee_name,e.street,e.city
from employee as e
join works as w
on e.employee_name = w.employee_name
where company_name = 'Agrani';

select e.employee_name,e.street,e.city
from employee as e
join works as w
on e.employee_name = w.employee_name
where company_name = 'Sonali' and salary*12>=120000;

select e.employee_name 
from employee as e
natural join company as c
natural join works as w
where e.city = c.city and w.company_name = c.company_name;

select employee_name 
from works 
where company_name != 'Sonali';

SELECT e.employee_name
FROM employee AS e
JOIN works AS w ON e.employee_name = w.employee_name
WHERE w.salary > ALL (
    SELECT w2.salary
    FROM works AS w2
    WHERE w2.company_name = 'Janata'
);





