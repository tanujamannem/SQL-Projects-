-- =====================================================================================
-- Topic: SQL JOINS
-- Author: Tanuja Mannem
-- Day: 4 - SQL Basics
-- Description: Understanding and using INNER, LEFT, RIGHT, FULL, SELF, and CROSS JOINs
-- =====================================================================================

-- ================================= THEORY ============================================
-- 1. JOINs Overview:
--    - JOINs combine rows from two or more tables based on a related column.
--    - Common types in SQL Server:
--        a) INNER JOIN   → Returns only matching rows in both tables.
--        b) LEFT JOIN    → Returns all rows from the left table, and matched rows from right table; NULL if no match.
--        c) RIGHT JOIN   → Returns all rows from the right table, and matched rows from left table; NULL if no match.
--        d) FULL OUTER JOIN → Returns all rows when there is a match in one of the tables.
--        e) SELF JOIN    → Joins a table to itself.
--        f) CROSS JOIN   → Returns Cartesian product (all possible combinations of rows).

-- 2. INNER JOIN:
--    - Syntax:
--         SELECT columns
--         FROM table1
--         INNER JOIN table2 ON table1.column = table2.column;
--    - Only rows with matching values in both tables are returned.

-- 3. LEFT JOIN / RIGHT JOIN:
--    - LEFT JOIN returns all rows from the left table, even if there is no match in the right table.
--    - RIGHT JOIN returns all rows from the right table, even if there is no match in the left table.
--    - Useful for finding unmatched data.

-- 4. FULL OUTER JOIN:
--    - Combines LEFT JOIN and RIGHT JOIN.
--    - Returns all rows from both tables; unmatched columns appear as NULL.

-- 5. SELF JOIN:
--    - A table joined to itself.
--    - Useful for hierarchical data, like employee-manager relationships.

-- 6. CROSS JOIN:
--    - Produces all possible combinations of rows between two tables.
--    - Usually used in reporting or generating combinations.

-- 7. Key Points:
--    - Always define the join condition (ON clause) to avoid Cartesian products (except CROSS JOIN).
--    - Use aliases (e.g., e, d) for readability.
--    - Join order matters for LEFT/RIGHT joins.
--    - SELF JOIN requires table aliasing to differentiate two instances of the same table.

-- =====================================================================================
-- ================================= CODE ==============================================

-- Drop if exists (for re-run safety)
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;

-- ============================================
--  Create Tables
-- ============================================

CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    salary DECIMAL(10,2),
    dept_id INT,
    manager_id INT NULL
);

-- ============================================
--  Insert Sample Data
-- ============================================

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
(106, 'Farhan', 52000, NULL, 101);

-- ============================================
--  INNER JOIN
-- ============================================

-- 1. Combine employee and department details
SELECT e.emp_name, e.salary, d.dept_name
FROM employees e
INNER JOIN departments d ON e.dept_id = d.dept_id;

-- 2. Employees earning above 50k with department name
SELECT e.emp_name, e.salary, d.dept_name
FROM employees e
INNER JOIN departments d ON e.dept_id = d.dept_id
WHERE e.salary > 50000;

-- ============================================
--  LEFT JOIN
-- ============================================

-- 3. Show all employees even if they don’t belong to a department
SELECT e.emp_name, d.dept_name
FROM employees e
LEFT JOIN departments d ON e.dept_id = d.dept_id;

-- ============================================
--  RIGHT JOIN
-- ============================================

-- 4. Show all departments even if no employees are assigned
SELECT e.emp_name, d.dept_name
FROM employees e
RIGHT JOIN departments d ON e.dept_id = d.dept_id;

-- ============================================
--  FULL OUTER JOIN
-- ============================================

-- 5. Combine all employees and departments (even without matches)
SELECT e.emp_name, d.dept_name
FROM employees e
FULL OUTER JOIN departments d ON e.dept_id = d.dept_id;

-- ============================================
--  SELF JOIN
-- ============================================

-- 6. Show employees with their manager names
SELECT e.emp_name AS Employee, m.emp_name AS Manager
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.emp_id;

-- ============================================
--  CROSS JOIN
-- ============================================

-- 7. Show every possible combination of employee and department
SELECT e.emp_name, d.dept_name
FROM employees e
CROSS JOIN departments d;

-- ============================================
--  Challenge Queries
-- ============================================

--  Find departments that have no employees
SELECT d.dept_name
FROM departments d
LEFT JOIN employees e ON d.dept_id = e.dept_id
WHERE e.emp_id IS NULL;

--  Find employees who don’t have a department assigned
SELECT emp_name
FROM employees
WHERE dept_id IS NULL;

--  Find manager name and count of employees reporting to them
SELECT m.emp_name AS Manager, COUNT(e.emp_id) AS Team_Size
FROM employees e
INNER JOIN employees m ON e.manager_id = m.emp_id
GROUP BY m.emp_name;


