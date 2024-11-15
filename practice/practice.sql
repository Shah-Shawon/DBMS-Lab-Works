CREATE database company;

use company;

create table payment_method(
	customer_id int primary key,
    cutomer varchar(50),
    mode varchar(50),
    city varchar(50)
);

insert into payment_method(customer_id,cutomer,mode,city)
values
(101,"Olivia Barrett","Netbanking","Portland"),
(102,"Ethan Sinclair","Crebit Card","Miami"),
(103,"Maya Harnandez","Crebit Card","Seattle"),
(104,"Liam Donovan","Netbanking","Denver"),
(105,"Sophia Nguyen","Crebit Card","New Orleans"),
(106,"Caleb Foster","Debit Card","Minneapolis"),
(107,"Ava Patel","Dedit Card","Phoenix"),
(108,"Lucas Carter","Netbanking","Boston"),
(109,"Isabella Martinez","Netbanking","Nashville"),
(110,"Jackson Brooks","Credit Card","Boston");


SELECT mode, count(cutomer)
from payment_method 
group by mode;




