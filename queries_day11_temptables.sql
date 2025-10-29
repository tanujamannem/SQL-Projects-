-- =============================================================
--  DAY 11 – TEMPORARY TABLES IN SQL
-- Author: Tanuja Mannem
-- Description:
--   Learn how to create and use Temporary Tables in SQL.
--   Understand Local (#) and Global (##) Temporary Tables.
-- =============================================================

-- =============================================================
--  THEORY
-- =============================================================

--  What are Temporary Tables?
-- Temporary tables are special tables used to store data temporarily
-- during a session or transaction. They are useful for holding
-- intermediate results and simplifying complex queries.

-- Types of Temporary Tables:
-- 1. Local Temporary Table (#TempTable)
--     - Exists only in the current session.
--     - Automatically dropped when the session ends.
--     - Name starts with a single # (e.g., #TempEmployees)
--
-- 2. Global Temporary Table (##TempTable)
--     - Accessible to all sessions.
--     - Dropped automatically when the last session using it is closed.
--     - Name starts with double ## (e.g., ##GlobalTemp)
--
--  Syntax:
--     SELECT columns INTO #TempTable FROM ExistingTable WHERE condition;
--     OR
--     CREATE TABLE #TempTable (columns datatype, ...);

-- =============================================================
--  Clean Start
-- =============================================================
DROP TABLE IF EXISTS #TempEmployees;
DROP TABLE IF EXISTS Departments;
DROP TABLE IF EXISTS Employees;
GO

-- =============================================================
-- 1. BASE TABLES
-- =============================================================
CREATE TABLE Departments (
    DeptID INT PRIMARY KEY,
    DeptName VARCHAR(50)
);
GO

CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50),
    DeptID INT,
    Salary DECIMAL(10,2),
    HireDate DATE,
    FOREIGN KEY (DeptID) REFERENCES Departments(DeptID)
);
GO

INSERT INTO Departments VALUES
(1, 'HR'), (2, 'Finance'), (3, 'IT'), (4, 'Marketing');

INSERT INTO Employees VALUES
(201, 'Amit', 1, 45000, '2022-05-10'),
(202, 'Bhavna', 2, 62000, '2021-03-12'),
(203, 'Chirag', 3, 71000, '2019-07-20'),
(204, 'Divya', 3, 82000, '2020-09-15'),
(205, 'Esha', 4, 50000, '2023-02-18');
GO

-- =============================================================
-- 2. LOCAL TEMP TABLE
-- =============================================================
-- Create a local temp table to store employees earning > 60000
SELECT EmpID, EmpName, Salary, DeptID
INTO #TempEmployees
FROM Employees
WHERE Salary > 60000;
GO

-- View data in temp table
SELECT * FROM #TempEmployees;
GO

-- Update temp table data
UPDATE #TempEmployees
SET Salary = Salary * 1.05;  -- 5% hike
GO

-- View updated records
SELECT * FROM #TempEmployees;
GO

-- Join temp table with another table
SELECT t.EmpName, d.DeptName, t.Salary
FROM #TempEmployees t
JOIN Departments d ON t.DeptID = d.DeptID;
GO

-- =============================================================
-- 3. GLOBAL TEMP TABLE (Optional)
-- =============================================================
-- ?? Can be accessed from multiple sessions
-- SELECT * INTO ##GlobalTemp FROM Employees;
-- SELECT * FROM ##GlobalTemp;
-- DROP TABLE ##GlobalTemp;
GO

-- =============================================================
--  CHALLENGE QUERIES
-- =============================================================

-- 1. Create a temp table for employees earning less than 55000
SELECT EmpID, EmpName, Salary, DeptID
INTO #LowSalary
FROM Employees
WHERE Salary < 55000;

SELECT * FROM #LowSalary;

-- 2. Add a new column 'Bonus' to #TempEmployees and update it
ALTER TABLE #TempEmployees ADD Bonus DECIMAL(10,2);

UPDATE #TempEmployees
SET Bonus = Salary * 0.10;

SELECT EmpName, Salary, Bonus FROM #TempEmployees;

-- 3. Create another temp table for department-wise average salary
SELECT DeptID, AVG(Salary) AS AvgSalary
INTO #DeptSalary
FROM Employees
GROUP BY DeptID;

SELECT * FROM #DeptSalary;

-- 4. Join #DeptSalary with Departments
SELECT d.DeptName, s.AvgSalary
FROM #DeptSalary s
JOIN Departments d ON s.DeptID = d.DeptID;

-- 5. Drop all temporary tables at the end
DROP TABLE IF EXISTS #TempEmployees;
DROP TABLE IF EXISTS #LowSalary;
DROP TABLE IF EXISTS #DeptSalary;
GO

-- =============================================================
--  END OF DAY 12
-- Key Learnings:
-- - Created and used Local and Global Temporary Tables
-- - Performed updates, joins, and aggregations on temp tables
-- - Practiced real-world temp table scenarios
-- =============================================================

