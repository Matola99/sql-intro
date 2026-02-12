show databases;
use mydb;
show tables;

-- simplilearn sql

create database sql_intro;

create table emp_details (name varchar(25), age int, sex char(1), doj date, city varchar(15), salary float); 
describe emp_details;
 
 insert into emp_details
 values ('lovemore',30,'m', '1990-09-09','mokopane', 7000),
 ('rethabile',28,'f','2009-01-04','pretoria',6500),
 ('simon',37,'m','1989-07-04','polokwane',5000),
 ('chicago',35,'f','1991-08-06','modimolle', 4500);
 select * from emp_details;
 
 select distinct city emp_details;
 
 select count(name) as count_name from emp_details;
 select sum(salary) from emp_details;
 select avg(salary) from emp_details;
 select name,age,city from emp_details;
 select * from emp_details where age >30;
 select name,sex,city from emp_details where sex ='f';
 select * from emp_details where city = 'mokopane' or city = 'pretoria';
 select *from emp_details where doj between '2000-01-01' and '2010-12-31';
 select * from emp_details where age >30 and sex = 'm';
 select sex, sum(salary) as total_salary from emp_details group by sex;
 select * from emp_details order by salary desc;
 select (10-20) as subtract;
 select length ('japan') as total_length;
 select repeat ('@', 10);
 select upper('japan');
 select curdate();
 select day(curdate());
 select now();
 
 
 
 
 
 # string functions
 select upper('india') as upper_case;
 select lower('INDIA') as lower_case;
 select lcase('INDIA') as lower_case;
 select character_length ('india') as total_len;
 select concat('india', ' is ', ' in asia') as merged;
 select replace('orange is a vegetable', 'vegetable', 'fruit');
 
 
 
 
 
 
 
 create table employees (emp_id int primary key, emp_name varchar(20), age int,gender char(1),doj date,dept varchar(20),city varchar(20),salary float);
 describe employees;
 insert into employees
 values( 100,'marcus',25, 'm', '2010-07-09','hr', 'thabazimbi', 90000),
 (98,'peter',34,'m','2009-08-02','product','lephalale',75000),
 (105,'rose',28,'f','1999-09-27','marketing','giyani',50000),
 (125,'sophia',33,'f','2013-04-30','sales','naboom',30000),
 (89,'robert',40,'m','2015-12-12','hr','mokopane',85000),
 (110,'maria',28,'f','2018-08-02','product','mokopane',30000);
 
 select * from employees;
 
 
 select distinct city from employees;
 select distinct dept from employees;
 select avg(age) from employees;
 
 
 #avg age each dept
 select dept, avg(age) as average_age from employees group by dept;
 select dept, sum(salary) as total_salary from employees group by dept;   
 
 #find depart where the avg salary is greater than 40000
 select dept,avg(salary) as avg_salary from employees
 group by dept
 having avg(salary) >30000;
 
 #find the cities where the total salary is greater than 45000
 select city, sum(salary) as total_salary from employees
 group by city
 having sum(salary) > 45000;
 
 #find the dept that has more than 1 employees
 select dept, count(*) as emp_count
 from employees
 group by dept
 having count(*) >1;
 
 #joins in sql
 create database sql_joins;
 show databases;
 use sql_joins;
 create table cricket (cricket_id int auto_increment, name varchar(30),primary key(cricket_id));
 
 create table football (football_id int auto_increment, name varchar(30),primary key(football_id));
 
 insert into cricket (name)
 values( 'stuart'), 
 ('michael'),
 ('johnson'),
 ('godfrey'),
 ('lovemore');
 truncate table cricket;
 select * from cricket;
 
 insert into football (name)
 values('johnson'),
 ('peter'),
 ('elisa'),
 ('lovemore'),
 ('godfrey');
 select * from football;
 
 #subquery
 #write a sql query to display department with maximum salary from employees tables
 use mydb;
show tables;

#select statement
select *from employees;
select emp_name,dept, salary from employees where salary < (select avg(salary)from employees);

#insert statement
create table products 
(prod_id int, item varchar(30), sell_price float, product_type varchar(30));
insert into products
values(101,'jewellery', 1800, 'luxury'),
(102,'t-shirt',100,'non-luxury'),
(103,'laptop',1300,'luxury'),
(104,'table',400,'non-luxury');
select * from products;

create table orders
(order_id int,product_sold varchar(30), sell_price float);
insert into orders
select prod_id, item,sell_price
from products where prod_id in (select prod_id from products where sell_price>1000);

select * from orders;

#triggers


create database triggers;
use triggers;
#before insert trigger

create table customers
(cust_id int, age int, name varchar(30));

delimiter //
create trigger age_verify
before insert on customers
for each row
if new.age < 0 then set new.age = 0;
end if; //

insert into customers
values(101,27,'james'),
(102, -40, 'ammy'),
(103, 32, 'ben'),
(104, -39, 'angela');

select * from customers;

#after insert trigger
create table customers1(
id int auto_increment primary key,
name varchar(40) not null,
email varchar(30),birthdate date);

create table message(
id int auto_increment,messageid int,message varchar(300) not null,
primary key(id, messageid));

delimiter //
create trigger 
check_null_dob
after insert
on customers1
for each row
begin 
if new.birthdate is null then 
insert into message(messageid , message)
values(new.id, concat('hi'  , new.name, ',  please update your date of birth'));
end if;
end//
delimiter ;

insert into customers1 (name, email,birthdate)
values('nancy', 'nancy@abc.com', null),
('ronald', 'ronald@xyz.com', '1998-11-16'),
('chris', 'chris@xyz.com', '1997-08-20'),
('alice', 'alice@anc.com', null);

select * from message;
truncate table message;
   
   