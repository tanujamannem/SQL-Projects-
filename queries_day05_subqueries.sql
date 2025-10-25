-- =====================================================================================
-- Topic: Subqueries
-- Author: Tanuja Mannem
-- Day: 5 - SQL Basics
-- Description: Using nested queries (IN, EXISTS, ANY, ALL, correlated) in SQL Server
-- =====================================================================================

-- ================================= THEORY ============================================
-- 1. Subquery Overview:
--    - A subquery (nested query) is a query inside another query.
--    - Can return a single value, a list of values, or a table.
--    - Common uses: filtering, calculating aggregates, comparing values.

-- 2. Subquery in WHERE Clause:
--    - Filters results based on the result of another query.
--    - Syntax:
--         SELECT columns
--         FROM table
--         WHERE column > (SELECT ...);
--    - Example:
--         SELECT emp_name, salary
--         FROM employees
--         WHERE salary > (SELECT AVG(salary) FROM employees);

-- 3. Subquery with IN / NOT IN:
--    - IN checks if a value exists in a list returned by subquery.
--    - NOT IN checks if a value does not exist in the list.
--    - Example:
--         SELECT emp_name
--         FROM employees
--         WHERE dept_id IN (SELECT dept_id FROM departments WHERE dept_name = 'IT');

-- 4. Subquery with EXISTS / NOT EXISTS:
--    - EXISTS returns TRUE if subquery returns at least one row.
--    - NOT EXISTS returns TRUE if subquery returns no rows.
--    - Example:
--         SELECT dept_name
--         FROM departments d
--         WHERE EXISTS (SELECT 1 FROM employees e WHERE e.dept_id = d.dept_id);

-- 5. Correlated Subquery:
--    - Subquery that references a column from the outer query.
--    - Evaluated for each row of the outer query.
--    - Example:
--         SELECT e.emp_name
--         FROM employees e
--         WHERE e.salary > (SELECT AVG(salary) FROM employees sub WHERE sub.dept_id = e.dept_id);

-- 6. Subquery with ANY / ALL:
--    - ANY → TRUE if comparison is TRUE for any value returned by subquery.
--    - ALL → TRUE if comparison is TRUE for all values returned by subquery.
--    - Example:
--         SELECT emp_name
--         FROM employees
--         WHERE salary > ANY (SELECT salary FROM employees WHERE dept_id = 1);

-- 7. Key Points:
--    - Subqueries can be used in SELECT, FROM, WHERE, and HAVING clauses.
--    - Correlated subqueries run once per row of the outer query.
--    - Use subqueries to handle complex filtering and aggregation.

-- =====================================================================================
-- ================================= CODE ==============================================

-- Drop and recreate for clean start
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;

CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    salary DECIMAL(10,2),
    dept_id INT,
    manager_id INT NULL,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

INSERT INTO departments (dept_id, dept_name) VALUES
(1, 'HR'),
(2, 'Finance'),
(3, 'IT'),
(4, 'Marketing');

INSERT INTO employees (emp_id, emp_name, salary, dept_id, manager_id) VALUES
(101, 'Amit', 55000, 3, NULL),
(102, 'Bhavna', 48000, 3, 101),
(103, 'Chirag', 60000, 2, NULL),
(104, 'Divya', 45000, 1, 103),
(105, 'Esha', 40000, 4, 103),
(106, 'Farhan', 52000, NULL, 101),
(107, 'Gauri', 35000, 2, 103);

-- ============================================
--  1. Subquery in WHERE clause : Write a query to display the names and salaries of employees who earn more than the average salary of all employees.
-- ============================================

SELECT emp_name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

-- ============================================
--  2. Subquery with IN : Write a query to find the names and department IDs of employees who work in departments named ‘IT’ or ‘Finance’.
-- ============================================

SELECT emp_name, dept_id
FROM employees
WHERE dept_id IN (SELECT dept_id FROM departments WHERE dept_name IN ('IT', 'Finance'));

-- ============================================
--  3. Subquery with EXISTS : Write a query to display the names of all departments that have at least one employee working in them.
-- ============================================

SELECT dept_name
FROM departments d
WHERE EXISTS (SELECT 1 FROM employees e WHERE e.dept_id = d.dept_id);

-- ============================================
--  4. Subquery with NOT EXISTS : Write a query to display the names of departments that do not have any employees.
-- ============================================

SELECT dept_name
FROM departments d
WHERE NOT EXISTS (SELECT 1 FROM employees e WHERE e.dept_id = d.dept_id);

-- ============================================
--  5. Correlated Subquery : Write a query to display the employee name, salary, and department ID for employees who earn more than the average salary of their respective department.
-- ============================================

SELECT e.emp_name, e.salary, e.dept_id
FROM employees e
WHERE e.salary > (
    SELECT AVG(salary)
    FROM employees sub
    WHERE sub.dept_id = e.dept_id
);

-- ============================================
--  6. Subquery with ANY / ALL
-- ============================================

-- 1. Write a query to display the names and salaries of employees whose salary is greater than any employee working in department 1.
SELECT emp_name, salary
FROM employees
WHERE salary > ANY (SELECT salary FROM employees WHERE dept_id = 1);

-- 2. Write a query to display the names and salaries of employees whose salary is greater than all employees working in department 1.
SELECT emp_name, salary
FROM employees
WHERE salary > ALL (SELECT salary FROM employees WHERE dept_id = 1);

-- ============================================
--  Challenge Queries
-- ============================================

-- Second highest salary
SELECT MAX(salary) AS SecondHighestSalary
FROM employees
WHERE salary < (SELECT MAX(salary) FROM employees);

-- Employees earning more than their manager
SELECT e.emp_name, e.salary, m.emp_name AS ManagerName, m.salary AS ManagerSalary
FROM employees e
JOIN employees m ON e.manager_id = m.emp_id
WHERE e.salary > m.salary;

-- Employees whose department avg salary > 50000
SELECT emp_name, dept_id
FROM employees
WHERE dept_id IN (
    SELECT dept_id
    FROM employees
    GROUP BY dept_id
    HAVING AVG(salary) > 50000
);





