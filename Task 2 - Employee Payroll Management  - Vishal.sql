-- Create database
CREATE DATABASE payroll_database;
USE payroll_database;

-- Create employees table
CREATE TABLE employees (
    EMPLOYEE_ID INT PRIMARY KEY,
    NAME TEXT,
    DEPARTMENT TEXT,
    EMAIL TEXT,
    PHONE_NO NUMERIC,
    JOINING_DATE DATE,
    SALARY NUMERIC,
    BONUS NUMERIC,
    TAX_PERCENTAGE NUMERIC
);

-- Inserting Values
INSERT INTO employees VALUES
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

-- Payroll Queries
-- 1. Retrieve the list of employees sorted by salary in descending order
SELECT * FROM employees
ORDER BY SALARY DESC;

-- 2. Find employees with a total compensation (SALARY + BONUS) greater than 100,000
SELECT * FROM employees
WHERE (SALARY + BONUS) > 100000;

-- 3. Update the bonus for employees in the ‘Sales’ department by 10%
UPDATE employees
SET BONUS = BONUS * 1.10
WHERE DEPARTMENT = 'Sales'
;

-- 4. Calculate the net salary after deducting tax for all employees
SELECT 
    EMPLOYEE_ID,
    NAME,
    SALARY,
    BONUS,
    TAX_PERCENTAGE,
    (SALARY + BONUS - ((SALARY + BONUS) * TAX_PERCENTAGE / 100)) AS NET_SALARY
FROM employees;

-- 5. Retrieve the average, minimum, and maximum salary per department
SELECT 
    DEPARTMENT,
    AVG(SALARY) AS AVG_SALARY,
    MIN(SALARY) AS MIN_SALARY,
    MAX(SALARY) AS MAX_SALARY
FROM employees
GROUP BY DEPARTMENT;


-- Advanced Queries
-- 1. Retrieve employees who joined in the last 6 months
SELECT * FROM employees
WHERE JOINING_DATE >= curdate() - INTERVAL 6 MONTH;

-- 2. Group employees by department and count how many employees each has
SELECT DEPARTMENT, COUNT(*) AS EMPLOYEE_COUNT
FROM employees
GROUP BY DEPARTMENT;

-- 3.Find the department with the highest average salary
SELECT DEPARTMENT
FROM employees
GROUP BY DEPARTMENT
ORDER BY AVG(SALARY) DESC
LIMIT 1;

-- 4. Identify employees who have the same salary as at least one other employee
SELECT * FROM employees
WHERE SALARY IN (
    SELECT SALARY FROM employees
    GROUP BY SALARY
    HAVING COUNT(*) > 1);
