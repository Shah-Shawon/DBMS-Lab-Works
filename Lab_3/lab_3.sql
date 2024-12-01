create database lab_3;

use lab_3;

create table person (
	nid varchar(20) primary key, 
	name varchar(50), 
	address varchar(50)
); 

insert into Person(nid,name,address) values
	('123451','Arif','Rajshahi'),
	('123452','Sumon','Moynamati'),
	('123453','Sagor','Sirajgang'),
	('123454','Abdul','Rajshahi'),
	('123455','Himesh','Dhaka'),
	('123456','Amirul','Sylhet'),
	('123457','Sajib','Chittagang');
create table car (
	license varchar(50) primary key, 
	year varchar(4), 
	model varchar(50)
);

insert into car(license, year, model) values
    ('12-3000','2012','Axio'),
    ('11-3000','2008','Corolla'),
    ('12-4000','2013','Axio'),
    ('12-5000','2013','Premio'),
    ('11-5000','2010','Nano'),
    ('11-6000','2011','Alto'),
    ('12-6000','2015','Nano Twist');
    
create table accident (
	date DATE, 
    driver varchar(50), 
    d_amount int,
    primary key (date,driver)
);	

insert into accident value(str_to_date('12/01/2013', '%d/%m/%Y'),'Arif',10000);
insert into accident value(STR_TO_DATE('25/09/2015', '%d/%m/%Y'),'Komol',12000);
insert into accident value(STR_TO_DATE('20/06/2014', '%d/%m/%Y'),'Bahadur',11000);
insert into accident value(STR_TO_DATE('20/12/2011', '%d/%m/%Y'),'Abdul',8000);
insert into accident value(STR_TO_DATE('19/09/2015', '%d/%m/%Y'),'Akter',7000);
insert into accident value(STR_TO_DATE('15/05/2013', '%d/%m/%Y'),'Arif',20000);
insert into accident value(STR_TO_DATE('20/08/2014', '%d/%m/%Y'),'Arif',15000);

create table owns (
nid varchar(20) , 
license varchar(50) ,
primary key (nid,license),
foreign key owns(nid) references person(nid),
foreign key owns(license) references car(license)
);

insert into owns(nid, license) values
    ('123451','11-3000'),
    ('123452','12-4000'),
    ('123453','12-5000'),
    ('123454','11-5000'),
    ('123455','11-6000'),
    ('123456','12-6000'),
    ('123457','12-3000');
    
CREATE TABLE log (
    license VARCHAR(50), 
    date DATE, 
    driver VARCHAR(50),
    PRIMARY KEY (license, date, driver),
    FOREIGN KEY (license) REFERENCES car(license),
    FOREIGN KEY (date, driver) REFERENCES accident(date, driver)
);

INSERT INTO log (license, date, driver) VALUES
		('11-3000','2013-01-12', 'Arif'),
		('12-4000','2015-09-25', 'Komol'),
		('11-6000','2014-06-20', 'Bahadur'),
		('11-5000','2011-12-20', 'Abdul'),
		('12-6000','2015-09-19', 'Akter'),
		('11-3000','2013-05-15', 'Arif'),
		('11-3000', '2014-08-20' , 'Arif');


set sql_safe_updates = 0;

select * from person;

select name from person
where address = 'Rajshahi';

select model
from car
where year = '2013';

select distinct driver
from accident
where d_amount between 10000 and 15000;

select nid
from owns as o
join car as c
on o.license = c.license
where c.model = 'Axio';

select p.name,p.address
from person as p
natural join car as c
natural join owns as o
where c.model = 'Alto';

select driver
from accident
where date = '2011-12-20';

select p.name 
from person as p
join owns as o
on p.nid = o.nid
where license = '12-4000';

select distinct p.name
from person as p
natural join owns as o
natural join log as l
where l.driver = 'Komol';

select c.model
from car as c
natural join log as l
natural join accident as a
where a.date = '2015-09-19';

select count(driver)
from accident
where driver = 'Arif';

select date
from accident 
where driver = 'Arif';

update person
set address = 'Natore'
where name = 'Arif';

select * from person;
