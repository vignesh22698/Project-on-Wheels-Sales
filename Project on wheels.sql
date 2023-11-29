use wheels;
create table newtitle
(
emp_no int,
title varchar(50),
from_date varchar(20)
);
load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/newtitle.csv" into table newtitle
fields terminated by ','
ignore 1 lines;
select count(*) from newtitle;

create table new_dept_emp(
emp_no int,
dept_no varchar(15),
from_date varchar(20)
);
load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/new_dept_emp.csv" into table new_dept_emp
fields terminated by ','
ignore 1 lines;
select count(*) from new_dept_emp;

create table employees(
emp_no int,
birth_date varchar(15),
first_name varchar(20),
last_name varchar(20),
gender char(1),
hire_date varchar(15)
);

load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/employees.csv" into table employees
fields terminated by ','
ignore 1 lines;

create table newsalaries (
emp_no int,
salary int,
from_date varchar(15)
);

load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/newsalaries.csv" into table newsalaries
fields terminated by ','
ignore 1 lines;

##scenario 1

select first_name, last_name,ns.salary from employees e
inner join newsalaries ns on e.emp_no=ns.emp_no
order by ns.salary desc
limit 10;

 select * from departments d
 inner join new_dept_emp nde on nde.dept_no= d.dept_no
 inner join employees e on e.emp_no = nde.emp_no
 where d.dept_name='Sales';
 select * from new_dept_emp;
 
 ## scenario 2
select first_name, last_name,ns.salary, d.dept_name, e.emp_no from employees e
inner join newsalaries ns on e.emp_no=ns.emp_no
inner join new_dept_emp nde on nde.emp_no= e.emp_no
inner join departments d on d.dept_no =nde.dept_no
order by ns.salary desc
limit 10;

## scenario 3
select d.dept_name, count(nde.emp_no) alias_count from  departments d
inner join new_dept_emp nde on d.dept_no=nde.dept_no
group by d.dept_name
order by alias_count desc
limit 3;

##scenario 4

select e.emp_no,d.dept_name,ns.salary from departments d
join new_dept_emp nde on d.dept_no=nde.dept_no
join employees e on e.emp_no=nde.emp_no
join newsalaries ns on e.emp_no=ns.emp_no
where d.dept_name="sales" 
and salary>(select avg(salary) from newsalaries ns
	inner join new_dept_emp nde on ns.emp_no=nde.emp_no
    inner join departments d on d.dept_no=nde.dept_no
    where dept_name='sales');
    
     #scenario 5
 
select  nt.title,avg(salary) as avg_salary from newtitle nt
join newsalaries ns on nt.emp_no=ns.emp_no
group by title
having avg(salary)>65000;
