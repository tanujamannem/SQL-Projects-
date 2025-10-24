-- =====================================================================================
-- Topic: ORDER BY, TOP, OFFSET FETCH
-- Author: Tanuja Mannem
-- Day: 2 - SQL Basics
-- Description: Sorting and limiting results using ORDER BY, TOP, and OFFSET FETCH in SQL Server
-- =====================================================================================

-- ================================= THEORY ============================================
-- 1. ORDER BY Clause:
--    - Used to sort query results by one or more columns.
--    - Syntax:
--         SELECT column1, column2, ...
--         FROM table_name
--         ORDER BY column1 [ASC|DESC], column2 [ASC|DESC], ...;
--    - ASC → ascending order (default)
--    - DESC → descending order
--    - Can sort by multiple columns; sorting occurs in the order specified.
--    - Example:
--         SELECT emp_name, salary FROM employees ORDER BY salary DESC;

-- 2. TOP Clause (SQL Server):
--    - Used to limit the number of rows returned.
--    - Syntax:
--         SELECT TOP n column1, column2, ...
--         FROM table_name
--         ORDER BY column;
--    - Example:
--         SELECT TOP 3 emp_name, salary FROM employees ORDER BY salary DESC;
--    - Returns the top 3 highest-paid employees in the example above.

-- 3. OFFSET FETCH (SQL Server):
--    - Used to skip a number of rows and fetch a specific number of rows.
--    - Syntax:
--         SELECT column1, column2, ...
--         FROM table_name
--         ORDER BY column
--         OFFSET x ROWS FETCH NEXT y ROWS ONLY;
--    - OFFSET → number of rows to skip
--    - FETCH NEXT → number of rows to retrieve
--    - Example:
--         SELECT emp_name, salary FROM employees ORDER BY salary DESC
--         OFFSET 2 ROWS FETCH NEXT 3 ROWS ONLY;

-- 4. Key Points:
--    - Always use ORDER BY with TOP or OFFSET FETCH to ensure predictable results.
--    - TOP is SQL Server specific; in other databases, LIMIT is used.
--    - OFFSET FETCH is useful for pagination.
--    - Multiple columns in ORDER BY help resolve ties (e.g., same salary).

-- =====================================================================================
-- ================================= CODE ==============================================

-- Create sample table
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    department VARCHAR(50),
    salary DECIMAL(10,2),
    hire_date DATE
);

-- Insert sample data
INSERT INTO employees (emp_id, emp_name, department, salary, hire_date) VALUES
(1, 'Amit', 'Finance', 65000, '2020-04-12'),
(2, 'Riya', 'Marketing', 58000, '2019-06-20'),
(3, 'John', 'HR', 72000, '2018-10-15'),
(4, 'Meera', 'IT', 82000, '2021-09-30'),
(5, 'Kiran', 'Finance', 75000, '2022-02-10'),
(6, 'David', 'IT', 62000, '2020-01-05'),
(7, 'Priya', 'Marketing', 56000, '2019-11-12'),
(8, 'Suresh', 'Finance', 70000, '2023-03-10');

-- ============================================
--  ORDER BY Examples
-- ============================================

-- 1. Sort all employees by salary (ascending)
SELECT emp_name, department, salary
FROM employees
ORDER BY salary ASC;

-- 2. Sort employees by salary (descending)
SELECT emp_name, department, salary
FROM employees
ORDER BY salary DESC;

-- 3. Sort by multiple columns (first department, then salary descending)
SELECT emp_name, department, salary
FROM employees
ORDER BY department ASC, salary DESC;

-- ============================================
--  TOP and OFFSET FETCH Examples
-- ============================================

-- 4. Display top 3 highest-paid employees
SELECT TOP 3 emp_name, department, salary
FROM employees
ORDER BY salary DESC;

-- 5. Display the 2 lowest-paid employees
SELECT TOP 2 emp_name, department, salary
FROM employees
ORDER BY salary ASC;

-- 6. Skip first 2 and fetch next 3 (OFFSET FETCH style)
SELECT emp_name, department, salary
FROM employees
ORDER BY salary DESC
OFFSET 2 ROWS FETCH NEXT 3 ROWS ONLY;

-- ============================================
--  Challenge Query
-- ============================================

-- Find top 2 employees with highest salary in IT department
SELECT TOP 2 emp_name, department, salary
FROM employees
WHERE department = 'IT'
ORDER BY salary DESC;


