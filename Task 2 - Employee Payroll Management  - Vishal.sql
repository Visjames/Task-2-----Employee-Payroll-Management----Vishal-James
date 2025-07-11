-- create database
create database payroll_database;
use payroll_database;

-- create employees table
create table employees (
  employee_id int primary key,
  name text,
  department text,
  email text,
  phone_no numeric,
  joining_date date,
  salary numeric,
  bonus numeric,
  tax_percentage numeric
);

-- inserting values
insert into employees values
(201, 'Rajesh Kumar', 'Sales', 'rajesh.kumar@example.in', 9123456780, '2025-01-10', 750000, 50000, 10),
(202, 'Anita Sharma', 'Engineering', 'anita.sharma@example.in', 9123456781, '2024-09-15', 1200000, 100000, 20),
(203, 'Ravi Verma', 'HR', 'ravi.verma@example.in', 9123456782, '2025-04-05', 600000, 30000, 10),
(204, 'Deepa Nair', 'Sales', 'deepa.nair@example.in', 9123456783, '2024-11-20', 800000, 60000, 12),
(205, 'Amit Joshi', 'Engineering', 'amit.joshi@example.in', 9123456784, '2023-10-10', 1300000, 150000, 18),
(206, 'Sonal Gupta', 'HR', 'sonal.gupta@example.in', 9123456785, '2025-02-28', 580000, 25000, 10),
(207, 'Karthik Reddy', 'Marketing', 'karthik.reddy@example.in', 9123456786, '2024-08-18', 850000, 50000, 15),
(208, 'Meera Iyer', 'Engineering', 'meera.iyer@example.in', 9123456787, '2025-03-10', 1150000, 120000, 20),
(209, 'Imran Khan', 'Sales', 'imran.khan@example.in', 9123456788, '2025-06-01', 900000, 70000, 10),
(210, 'Priya Desai', 'Marketing', 'priya.desai@example.in', 9123456789, '2024-12-12', 880000, 65000, 14);

-- payroll queries

-- 1. retrieve the list of employees sorted by salary in descending order
select * from employees
order by salary desc;

-- 2. find employees with a total compensation (salary + bonus) greater than 100,000
select * from employees
where (salary + bonus) > 100000;

-- 3. update the bonus for employees in the ‘Sales’ department by 10%
update employees
set bonus = bonus * 1.10
where department = 'Sales';

-- 4. calculate the net salary after deducting tax for all employees
select
  employee_id,
  name,
  salary,
  bonus,
  tax_percentage,
  (salary + bonus - ((salary + bonus) * tax_percentage / 100)) as net_salary
from employees;

-- 5. retrieve the average, minimum, and maximum salary per department
select
  department,
  avg(salary) as avg_salary,
  min(salary) as min_salary,
  max(salary) as max_salary
from employees
group by department;

-- advanced queries

-- 1. retrieve employees who joined in the last 6 months
select * from employees
where joining_date >= curdate() - interval 6 month;

-- 2. group employees by department and count how many employees each has
select department, count(*) as employee_count
from employees
group by department;

-- 3. find the department with the highest average salary
select department
from employees
group by department
order by avg(salary) desc
limit 1;

-- 4. identify employees who have the same salary as at least one other employee
select * from employees
where salary in (
  select salary from employees
  group by salary
  having count(*) > 1);
