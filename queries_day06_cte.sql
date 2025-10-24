-- ============================================
--  Topic: Common Table Expressions (CTE)
--  Day 6 - Intermediate SQL
--  Focus: Reusable query blocks, simplifying subqueries
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
    manager_id INT NULL
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
(106, 'Farhan', 52000, 2, 103),
(107, 'Gauri', 35000, 1, 104);

-- ============================================
--  1?. Simple CTE example
-- ============================================

-- Create a CTE to calculate department-wise average salary
WITH DeptAvg AS (
    SELECT dept_id, AVG(salary) AS avg_salary
    FROM employees
    GROUP BY dept_id
)
SELECT e.emp_name, e.salary, d.dept_name, a.avg_salary
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
JOIN DeptAvg a ON e.dept_id = a.dept_id
WHERE e.salary > a.avg_salary;

-- ============================================
--  2?. CTE replacing subqueries
-- ============================================

-- Find top 3 highest-paid employees using a CTE
WITH EmpRank AS (
    SELECT emp_name, salary,
           ROW_NUMBER() OVER (ORDER BY salary DESC) AS rn
    FROM employees
)
SELECT emp_name, salary
FROM EmpRank
WHERE rn <= 3;

-- ============================================
--  3?. Multiple CTEs in one query
-- ============================================

-- Combine multiple CTEs for better readability
WITH DeptCount AS (
    SELECT dept_id, COUNT(*) AS emp_count
    FROM employees
    GROUP BY dept_id
),
DeptAvg AS (
    SELECT dept_id, AVG(salary) AS avg_salary
    FROM employees
    GROUP BY dept_id
)
SELECT d.dept_name, c.emp_count, a.avg_salary
FROM departments d
JOIN DeptCount c ON d.dept_id = c.dept_id
JOIN DeptAvg a ON d.dept_id = a.dept_id;

-- ============================================
--  4?. Recursive CTE
-- ============================================

-- Example: Display employee-manager hierarchy
WITH EmployeeHierarchy AS (
    SELECT emp_id, emp_name, manager_id, 0 AS level
    FROM employees
    WHERE manager_id IS NULL

    UNION ALL

    SELECT e.emp_id, e.emp_name, e.manager_id, h.level + 1
    FROM employees e
    INNER JOIN EmployeeHierarchy h ON e.manager_id = h.emp_id
)
SELECT * FROM EmployeeHierarchy
ORDER BY level, emp_id;

-- ============================================
--  Challenge Queries
-- ============================================

--  Find each department's highest-paid employee using a CTE
WITH DeptHigh AS (
    SELECT dept_id, emp_name, salary,
           ROW_NUMBER() OVER (PARTITION BY dept_id ORDER BY salary DESC) AS rn
    FROM employees
)
SELECT dept_id, emp_name, salary
FROM DeptHigh
WHERE rn = 1;

--  Find employees who earn above overall average salary using CTE
WITH AvgSal AS (
    SELECT AVG(salary) AS avg_salary FROM employees
)
SELECT emp_name, salary
FROM employees, AvgSal
WHERE salary > avg_salary;
