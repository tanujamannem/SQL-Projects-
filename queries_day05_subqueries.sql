-- ============================================
--  Topic: Subqueries
--  Day 5 - SQL Basics
--  Focus: Nested queries (IN, EXISTS, ANY, ALL)
-- ============================================

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
--  1. Subquery in WHERE clause
-- ============================================

SELECT emp_name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

-- ============================================
--  2. Subquery with IN
-- ============================================

SELECT emp_name, dept_id
FROM employees
WHERE dept_id IN (SELECT dept_id FROM departments WHERE dept_name IN ('IT', 'Finance'));

-- ============================================
--  3. Subquery with EXISTS
-- ============================================

SELECT dept_name
FROM departments d
WHERE EXISTS (SELECT 1 FROM employees e WHERE e.dept_id = d.dept_id);

-- ============================================
--  4. Subquery with NOT EXISTS
-- ============================================

SELECT dept_name
FROM departments d
WHERE NOT EXISTS (SELECT 1 FROM employees e WHERE e.dept_id = d.dept_id);

-- ============================================
--  5. Correlated Subquery
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

SELECT emp_name, salary
FROM employees
WHERE salary > ANY (SELECT salary FROM employees WHERE dept_id = 1);

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


