-- =============================================================
-- ?? DAY 13 – STORED PROCEDURES & FUNCTIONS
-- Author: Tanuja Mannem
-- Description:
--   Learn how to create, execute, and manage Stored Procedures 
--   and User-Defined Functions in SQL.
-- =============================================================

-- =============================================================
-- ?? THEORY
-- =============================================================

-- ?? What is a Stored Procedure?
-- A Stored Procedure is a precompiled block of SQL code 
-- that can be executed multiple times.
-- It helps to modularize code, improve performance, 
-- and reduce repetitive SQL writing.

-- ? Benefits:
-- - Improves performance (precompiled)
-- - Increases reusability
-- - Supports parameters
-- - Enhances security (controlled access)

-- ?? Syntax (SQL Server Style):
-- CREATE PROCEDURE procedure_name
-- AS
-- BEGIN
--     SQL statements
-- END;
--
-- ?? With Parameters:
-- CREATE PROCEDURE procedure_name @param1 datatype, @param2 datatype
-- AS
-- BEGIN
--     SQL statements using parameters
-- END;

-- ?? Execute:
-- EXEC procedure_name;
-- EXEC procedure_name @param1 = value1, @param2 = value2;

-- =============================================================
-- ?? BASE TABLES
-- =============================================================
DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS Departments;
GO

CREATE TABLE Departments (
    DeptID INT PRIMARY KEY,
    DeptName VARCHAR(50)
);

CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50),
    DeptID INT,
    Salary DECIMAL(10,2),
    HireDate DATE,
    FOREIGN KEY (DeptID) REFERENCES Departments(DeptID)
);

INSERT INTO Departments VALUES
(1, 'HR'), (2, 'Finance'), (3, 'IT');

INSERT INTO Employees VALUES
(101, 'Amit', 1, 50000, '2022-01-10'),
(102, 'Bhavna', 2, 60000, '2021-02-14'),
(103, 'Chirag', 3, 75000, '2020-06-20'),
(104, 'Divya', 3, 80000, '2019-08-05');
GO

-- =============================================================
-- ?? 1?? CREATE SIMPLE STORED PROCEDURE
-- =============================================================

-- Procedure to display all employees
CREATE PROCEDURE GetAllEmployees
AS
BEGIN
    SELECT * FROM Employees;
END;
GO

-- Execute procedure
EXEC GetAllEmployees;
GO

-- =============================================================
-- ?? 2?? STORED PROCEDURE WITH PARAMETERS
-- =============================================================

-- Procedure to get employees by department
CREATE PROCEDURE GetEmployeesByDept
    @DeptID INT
AS
BEGIN
    SELECT EmpName, Salary, DeptID
    FROM Employees
    WHERE DeptID = @DeptID;
END;
GO

-- Execute procedure with parameter
EXEC GetEmployeesByDept @DeptID = 3;
GO

-- =============================================================
-- ?? 3?? STORED PROCEDURE WITH INPUT + OUTPUT PARAMETERS
-- =============================================================

-- Procedure to calculate total salary in a department
CREATE PROCEDURE GetTotalSalaryByDept
    @DeptID INT,
    @TotalSalary DECIMAL(10,2) OUTPUT
AS
BEGIN
    SELECT @TotalSalary = SUM(Salary)
    FROM Employees
    WHERE DeptID = @DeptID;
END;
GO

-- Declare variable to hold output value
DECLARE @SalarySum DECIMAL(10,2);
EXEC GetTotalSalaryByDept @DeptID = 3, @TotalSalary = @SalarySum OUTPUT;
SELECT @SalarySum AS Total_Salary_For_Dept3;
GO

-- =============================================================
-- ?? 4?? CREATE USER-DEFINED FUNCTION (UDF)
-- =============================================================

-- ?? Functions return a single value or a table.
-- Used inside SELECT queries or other SQL statements.

-- Example 1: Scalar Function – Returns single value
CREATE FUNCTION GetAnnualSalary (@MonthlySalary DECIMAL(10,2))
RETURNS DECIMAL(10,2)
AS
BEGIN
    RETURN @MonthlySalary * 12;
END;
GO

-- Use the function
SELECT EmpName, Salary, dbo.GetAnnualSalary(Salary) AS AnnualSalary
FROM Employees;
GO

-- Example 2: Table-Valued Function – Returns a result set
CREATE FUNCTION GetHighEarners (@MinSalary DECIMAL(10,2))
RETURNS TABLE
AS
RETURN (
    SELECT EmpID, EmpName, Salary
    FROM Employees
    WHERE Salary > @MinSalary
);
GO

-- Use table-valued function
SELECT * FROM dbo.GetHighEarners(60000);
GO

-- =============================================================
-- ?? 5?? MODIFY / DELETE PROCEDURES AND FUNCTIONS
-- =============================================================
-- ALTER PROCEDURE GetAllEmployees AS SELECT EmpID, EmpName FROM Employees;
-- DROP PROCEDURE GetEmployeesByDept;
-- DROP FUNCTION GetAnnualSalary;

-- =============================================================
-- ?? CHALLENGE QUERIES
-- =============================================================

-- 1?? Create a procedure that shows employees hired after 2021.
CREATE PROCEDURE GetRecentHires
AS
BEGIN
    SELECT EmpName, HireDate FROM Employees WHERE HireDate > '2021-01-01';
END;
GO

EXEC GetRecentHires;
GO

-- 2?? Create a function that returns bonus (10% of salary)
CREATE FUNCTION GetBonus(@Salary DECIMAL(10,2))
RETURNS DECIMAL(10,2)
AS
BEGIN
    RETURN @Salary * 0.10;
END;
GO

SELECT EmpName, Salary, dbo.GetBonus(Salary) AS Bonus FROM Employees;
GO

-- =============================================================
-- ? END OF DAY 13
-- Key Learnings:
-- - Created Stored Procedures (with and without parameters)
-- - Created Scalar and Table-Valued Functions
-- - Used EXEC and OUTPUT parameters
-- - Practical mini exercises and reusable SQL modules
-- =============================================================
