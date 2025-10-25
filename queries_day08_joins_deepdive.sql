-- =============================================
--  SQL PRACTICE: DAY 8 – JOINS
-- Covers: INNER, LEFT, RIGHT, FULL, CROSS, SELF JOIN
-- =============================================

-- Drop child tables first, then parent
DROP TABLE IF EXISTS Projects;
DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS Departments;

--  Create Departments table
CREATE TABLE Departments (
    DeptID INT PRIMARY KEY,
    DeptName VARCHAR(50)
);

INSERT INTO Departments VALUES
(1, 'HR'),
(2, 'Finance'),
(3, 'IT');

--  Create Employees table
CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50),
    DeptID INT,
    Salary DECIMAL(10,2),
    FOREIGN KEY (DeptID) REFERENCES Departments(DeptID)
);

INSERT INTO Employees VALUES
(101, 'Alice', 1, 50000),
(102, 'Bob', 2, 60000),
(103, 'Charlie', 3, 55000),
(104, 'David', 2, 62000),
(105, 'Eva', NULL, 48000);

--  Create Projects table
CREATE TABLE Projects (
    ProjID INT PRIMARY KEY,
    ProjName VARCHAR(50),
    DeptID INT,
    FOREIGN KEY (DeptID) REFERENCES Departments(DeptID)
);

INSERT INTO Projects VALUES
(201, 'Payroll System', 2),
(202, 'Recruitment Portal', 1),
(203, 'Network Setup', 3);

-- =============================================
--  INNER JOIN
-- =============================================
-- Returns records where there is a match in both tables
SELECT e.EmpName, d.DeptName
FROM Employees e
INNER JOIN Departments d ON e.DeptID = d.DeptID;

-- =============================================
--  LEFT JOIN
-- =============================================
-- Returns all employees and matching departments (if any)
SELECT e.EmpName, d.DeptName
FROM Employees e
LEFT JOIN Departments d ON e.DeptID = d.DeptID;

-- =============================================
--  RIGHT JOIN
-- =============================================
-- Returns all departments and their employees (if any)
SELECT e.EmpName, d.DeptName
FROM Employees e
RIGHT JOIN Departments d ON e.DeptID = d.DeptID;

-- =============================================
--  FULL OUTER JOIN (MySQL alternative using UNION)
-- =============================================
SELECT e.EmpName, d.DeptName
FROM Employees e
LEFT JOIN Departments d ON e.DeptID = d.DeptID
UNION
SELECT e.EmpName, d.DeptName
FROM Employees e
RIGHT JOIN Departments d ON e.DeptID = d.DeptID;

-- =============================================
--  CROSS JOIN
-- =============================================
-- Returns all possible combinations of employees and departments
SELECT e.EmpName, d.DeptName
FROM Employees e
CROSS JOIN Departments d;

-- =============================================
--  SELF JOIN
-- =============================================
-- Compare employees with higher salaries than others
SELECT e1.EmpName AS Employee, e2.EmpName AS HigherSalaryEmployee
FROM Employees e1
JOIN Employees e2 ON e1.Salary < e2.Salary;

-- =============================================
--  MINI PROJECT: Employees + Departments + Projects
-- =============================================
-- Combine three tables to show employee, department, and project info
SELECT e.EmpName, d.DeptName, p.ProjName
FROM Employees e
JOIN Departments d ON e.DeptID = d.DeptID
JOIN Projects p ON d.DeptID = p.DeptID
ORDER BY d.DeptName;
