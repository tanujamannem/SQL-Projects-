-- =============================================================
--  DAY 11 – VIEWS IN SQL
--  Author: Tanuja Mannem
--  Description:
--      Learn what Views are, how to create, modify, and use them.
--      Understand simple and complex views with examples.
-- =============================================================

-- =============================================================
--  THEORY
-- =============================================================

-- ?? What is a View?
-- A VIEW is a virtual table that displays data from one or more tables.
-- It does not store data physically — instead, it saves the SQL query.
-- When you query a view, SQL Server executes the underlying query.

-- ?? Why use Views?
-- - To simplify complex queries
-- - To restrict access to sensitive data
-- - To reuse frequently used queries
-- - To provide data abstraction (hide table structure)

-- ?? Syntax:
-- CREATE VIEW view_name AS
-- SELECT columns
-- FROM tables
-- WHERE condition;

-- To see data from a view:
-- SELECT * FROM view_name;

-- ?? Types of Views:
-- 1. Simple View – based on a single table (can allow DML operations)
-- 2. Complex View – based on multiple tables or with aggregations (read-only)

-- =============================================================
--  CLEAN START
-- =============================================================

-- Drop foreign key dynamically before dropping tables
DECLARE @sql NVARCHAR(MAX);
SELECT @sql = (
    SELECT 'ALTER TABLE [' + OBJECT_NAME(parent_object_id) + '] DROP CONSTRAINT [' + name + '];'
    FROM sys.foreign_keys
    WHERE referenced_object_id = OBJECT_ID('Departments')
);
IF @sql IS NOT NULL EXEC sp_executesql @sql;
GO

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

-- 1?? Simple View: Show employee basic details
CREATE VIEW vw_EmployeeBasic AS
SELECT EmpID, EmpName, Salary
FROM Employees;
GO

-- Use the view
SELECT * FROM vw_EmployeeBasic;
GO

-- 2?? Simple View: Filtered view (employees earning > 60000)
CREATE VIEW vw_HighEarners AS
SELECT EmpName, Salary, DeptID
FROM Employees
WHERE Salary > 60000;
GO

SELECT * FROM vw_HighEarners;
GO

-- 3?? Complex View: Join Employees and Departments
CREATE VIEW vw_EmployeeDept AS
SELECT e.EmpName, e.Salary, d.DeptName, e.HireDate
FROM Employees e
JOIN Departments d ON e.DeptID = d.DeptID;
GO

SELECT * FROM vw_EmployeeDept;
GO

-- 4?? Complex View: Department-wise average salary
CREATE VIEW vw_DeptAvgSalary AS
SELECT d.DeptName, AVG(e.Salary) AS AvgSalary
FROM Employees e
JOIN Departments d ON e.DeptID = d.DeptID
GROUP BY d.DeptName;
GO

SELECT * FROM vw_DeptAvgSalary;
GO

-- 5?? Updating data through a simple view
UPDATE vw_EmployeeBasic
SET Salary = Salary + 5000
WHERE EmpID = 1;
GO

SELECT * FROM vw_EmployeeBasic;
GO

-- 6?? Check all views in the database
SELECT name AS ViewName
FROM sys.views;
GO

-- =============================================================
--  MODIFYING AND DROPPING VIEWS
-- =============================================================

-- Modify existing view
ALTER VIEW vw_HighEarners AS
SELECT EmpName, Salary, DeptID
FROM Employees
WHERE Salary > 65000;
GO

SELECT * FROM vw_HighEarners;
GO

-- Drop a view
DROP VIEW IF EXISTS vw_DeptAvgSalary;
GO

-- =============================================================
--  CHALLENGE QUERIES
-- =============================================================

-- ?? 1. Create a view showing employees who joined after 2021
CREATE VIEW vw_RecentHires AS
SELECT EmpName, HireDate, DeptID
FROM Employees
WHERE HireDate >= '2021-01-01';
GO

SELECT * FROM vw_RecentHires;
GO

-- ?? 2. Create a complex view showing each department’s highest-paid employee
CREATE VIEW vw_TopPaidPerDept AS
SELECT d.DeptName, e.EmpName, e.Salary
FROM Employees e
JOIN Departments d ON e.DeptID = d.DeptID
WHERE e.Salary = (
    SELECT MAX(Salary)
    FROM Employees sub
    WHERE sub.DeptID = e.DeptID
);
GO

SELECT * FROM vw_TopPaidPerDept;
GO

-- =============================================================
--  END OF DAY 11
--  Key Learnings:
--  - Created and used simple & complex views
--  - Updated data through simple views
--  - Learned how to modify and drop views
-- =============================================================
