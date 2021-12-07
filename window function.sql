show databases;
create database winfunction;
use winfunction;
create table employee(id int,name varchar(10),job varchar(10),salary float);
insert into employee values(1,'vishal','analyst',23400);
insert into employee values(2,'shubham','Ds',32500),(3,'komal','Ds',35000),(4,'shina','analyst',51000);
select * from employee;
select *, sum(salary) OVER() as total_salary from employee;
select *, sum(salary) OVER(partition by job) as total_salary from employee;
select *, sum(salary) OVER(partition by job order by salary desc) as total_salary from employee;
#row number
select *, row_number() over() as rownumber from employee;
select *, row_number() OVER(partition by job) as partitionByJobs from employee;
insert into employee values(5,'shewt','Ds',34500),(6,'king','Ds',56000),(7,'miraa','analyst',51000),(8,'ram','analyst',34900);
select * from employee;
#rank
select *, ROW_NUMBER() over(partition by job order by salary) as "row_number",
RANK() over(partition by job order by salary) as "rank_row" 
from employee;
#dense rank
insert into employee values(10,'vaibh','analyst',34000);
/*Print first value within each partition using nth_value function*/
select *, NTH_VALUE(name, 1) over(partition by job order by salary asc RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as "FIRST"
from employee;
/*Print last value within each partition using nth_value function*/
select *, 
NTH_VALUE(name, 1) over(partition by job order by salary DESC RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as "LAST"
from employee;
/*Print nth value within each partition using nth_value function*/
select *, 
NTH_VALUE(name, 3) over(partition by job order by salary RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as "THIRD"
from employee;
/*Statistics using ntile function*/
select *, 
NTILE(4) over(order by salary) as "quartile"
from employee;
/*Lead values*/
select *,
LEAD(salary, 1) Over(partition by job order by salary) as sal_next
from employee;
/*Lag values*/
select *,
LAG(salary, 1) Over(partition by job order by salary) as sal_previous,
salary - LAG(salary, 1) Over(partition by job order by salary) as sal_diff
from employee;