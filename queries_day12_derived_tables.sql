-- =============================================================
--  DAY 12 – DERIVED TABLES (SUBQUERIES IN FROM CLAUSE)
--  Author: Tanuja Mannem
--  Description:
--      Learn how to use Derived Tables in SQL.
--      Understand how subqueries inside FROM act as temporary result sets.
-- =============================================================

-- =============================================================
--  THEORY
-- =============================================================

--  What are Derived Tables?
-- A Derived Table is a subquery written inside the FROM clause.
-- It acts like a temporary table that exists only for the duration
-- of that query. It is also known as an "inline view".

--  Why use Derived Tables?
-- - To simplify complex queries
-- - To perform calculations and reuse them in outer queries
-- - To avoid creating physical or temporary tables

--  Syntax:
-- SELECT columns
-- FROM (SELECT ... FROM ... WHERE ...) AS alias_name
-- WHERE condition;

-- Example:
-- SELECT d.DeptName, avg_data.AvgSalary
-- FROM (
--        SELECT DeptID, AVG(Salary) AS AvgSalary
--        FROM Employees
--        GROUP BY DeptID
--      ) AS avg_data
-- JOIN Departments d ON avg_data.DeptID = d.DeptID;

-- =============================================================
--  CLEAN START
-- =============================================================

-- Drop existing foreign keys dynamically before dropping tables
DECLARE @sql NVARCHAR(MAX);
SELECT @sql = (
    SELECT 'ALTER TABLE [' + OBJECT_NAME(parent_object_id) + '] DROP CONSTRAINT [' + name + '];'
    FROM sys.foreign_keys
    WHERE referenced_object_id = OBJECT_ID('Departments')
);
IF @sql IS NOT NULL EXEC sp_executesql @sql;
GO

-- Drop tables if exist
DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS Departments;
GO

-- =============================================================
--  BASE TABLES
-- =============================================================

CREATE TABLE Departments (
    DeptID INT IDENTITY(1,1) PRIMARY KEY,
    DeptName VARCHAR(50)
);
GO

CREATE TABLE Employees (
    EmpID INT IDENTITY(1,1) PRIMARY KEY,
    EmpName VARCHAR(50),
    DeptID INT,
    Salary DECIMAL(10,2),
    HireDate DATE,
    FOREIGN KEY (DeptID) REFERENCES Departments(DeptID)
);
GO

INSERT INTO Departments (DeptName) VALUES
('HR'), ('Finance'), ('IT'), ('Marketing');
GO

INSERT INTO Employees (EmpName, DeptID, Salary, HireDate) VALUES
('Amit', 1, 45000, '2022-05-10'),
('Bhavna', 2, 62000, '2021-03-12'),
('Chirag', 3, 71000, '2019-07-20'),
('Divya', 3, 82000, '2020-09-15'),
('Esha', 4, 50000, '2023-02-18'),
('Farhan', 2, 65000, '2020-04-22'),
('Garima', 4, 47000, '2021-09-09');
GO

-- =============================================================
--  EXAMPLES
-- =============================================================

-- 1. Derived Table to calculate department-wise average salary
SELECT d.DeptName, avg_data.AvgSalary
FROM (
    SELECT DeptID, AVG(Salary) AS AvgSalary
    FROM Employees
    GROUP BY DeptID
) AS avg_data
JOIN Departments d ON avg_data.DeptID = d.DeptID;
GO

-- 2. Derived Table to find employees earning above department average
SELECT e.EmpName, e.Salary, d.DeptName
FROM Employees e
JOIN Departments d ON e.DeptID = d.DeptID
WHERE e.Salary > (
    SELECT AVG(Salary)
    FROM Employees sub
    WHERE sub.DeptID = e.DeptID
);
GO

-- 3. Derived Table for recent hires (last 2 years)
SELECT EmpName, DeptName, HireDate
FROM (
    SELECT e.EmpName, d.DeptName, e.HireDate
    FROM Employees e
    JOIN Departments d ON e.DeptID = d.DeptID
    WHERE e.HireDate >= DATEADD(YEAR, -2, GETDATE())
) AS recent_employees;
GO

-- 4. Derived Table for Top 2 Salaries per Department
SELECT d.DeptName, t.EmpName, t.Salary
FROM (
    SELECT EmpName, DeptID, Salary,
           ROW_NUMBER() OVER(PARTITION BY DeptID ORDER BY Salary DESC) AS rn
    FROM Employees
) AS t
JOIN Departments d ON t.DeptID = d.DeptID
WHERE t.rn <= 2;
GO

-- =============================================================
--  CHALLENGE QUERIES
-- =============================================================

-- 1. Find employees who earn more than the overall average salary
SELECT EmpName, Salary
FROM Employees
WHERE Salary > (SELECT AVG(Salary) FROM Employees);

-- 2. Using a derived table, show department names with total salary > 100000
SELECT d.DeptName, totals.TotalSalary
FROM (
    SELECT DeptID, SUM(Salary) AS TotalSalary
    FROM Employees
    GROUP BY DeptID
) AS totals
JOIN Departments d ON totals.DeptID = d.DeptID
WHERE totals.TotalSalary > 100000;

-- 3. Using a derived table, count how many employees joined after 2021 per department
SELECT d.DeptName, recent.CountEmp
FROM (
    SELECT DeptID, COUNT(*) AS CountEmp
    FROM Employees
    WHERE HireDate > '2021-01-01'
    GROUP BY DeptID
) AS recent
JOIN Departments d ON d.DeptID = recent.DeptID;

-- =============================================================
--  END OF DAY 12
--  Key Learnings:
--  - Derived tables act like temporary result sets within a query
--  - Useful for aggregations, filtering, and window functions
--  - Simplify multi-step logic without using temp tables
-- =============================================================


