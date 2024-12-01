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

-- Find all employees who earn more than each employee of "Janata" Bank.

SELECT e.employee_name
FROM works e
WHERE e.salary > ALL (
    SELECT w.salary
    FROM works w
    WHERE w.company_name = 'Janata'
);

-- Find all employees who earn more than the average salary of all employees of their companies.

SELECT employee_name
FROM works w
WHERE salary > (
    SELECT AVG(salary)
    FROM works w2
    WHERE w2.company_name = w.company_name
);


-- Find the company that has the most employees.
SELECT company_name
FROM works
GROUP BY company_name
ORDER BY COUNT(employee_name) DESC
LIMIT 1;

--  Find the company that has the smallest payroll.
SELECT company_name
FROM works
GROUP BY company_name
ORDER BY SUM(salary) ASC
LIMIT 1;

-- Find those companies whose employees earn a higher salary, on average, than the average salary at "Agrani".

SELECT company_name
FROM works 
GROUP by company_name
HAVING AVG(salary)>(
    SELECT AVG(salary)
    FROM works
    WHERE company_name = 'Agrani'
);

-- Modify the database so that "Arif" now lives in Natore
UPDATE works
SET salary = salary * 1.10
WHERE company_name = 'Agrani';

-- Give all managers of "Agrani" Bank a 10% salary raise.
UPDATE works
SET salary = salary * 1.10
WHERE employee_name IN (
    SELECT employee_name
    FROM manages
) AND company_name = 'Agrani';

--  Give all managers a 10% salary raise unless their salary becomes greater than 19,000; in such cases, give only a 3% salary raise.
UPDATE works
SET salary = CASE
    WHEN salary * 1.10 <= 19000 THEN salary * 1.10
    ELSE salary * 1.03
END
WHERE employee_name IN (SELECT employee_name FROM manages);

-- Delete all tuples in the works relation for employees of "Janata" Bank.
DELETE FROM works
WHERE company_name = 'Janata';

-- Define a view consisting of manager-name and average salary of all employees who work for that manager.
CREATE VIEW manager_avg_salary AS
SELECT m.manager_name, AVG(w.salary) AS avg_salary
FROM manages m
JOIN works w ON m.employee_name = w.employee_name
GROUP BY m.manager_name;







