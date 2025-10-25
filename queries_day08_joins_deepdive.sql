-- =============================================
--  📘 Topic: SQL JOINS
--  🗓️ Day 8 – Intermediate SQL
--  👩‍💻 Author: Tanuja Mannem
--  🎯 Focus: INNER, LEFT, RIGHT, FULL, CROSS, SELF JOINS
-- =============================================

/*
================================================================================
🧠 THEORY SECTION
================================================================================

🔹 1. What are JOINS?
Joins are used to combine rows from two or more tables based on a related column 
between them. They help fetch data from multiple tables in a single query.

📌 Syntax:
    SELECT columns
    FROM table1
    JOIN table2
    ON table1.common_column = table2.common_column;

---

🔹 2. Types of Joins:

1️⃣ INNER JOIN  
   → Returns only the records that have matching values in both tables.  
   Example: Show only employees who belong to a valid department.

2️⃣ LEFT JOIN  
   → Returns all rows from the left table (even if no match in right table).  
   Example: Show all employees and their department (NULL if no department).

3️⃣ RIGHT JOIN  
   → Returns all rows from the right table, even if no match in left table.  
   Example: Show all departments and employees (if any).

4️⃣ FULL OUTER JOIN  
   → Returns all records when there is a match in either table.
   MySQL doesn’t support FULL JOIN directly — we can simulate it using UNION.

5️⃣ CROSS JOIN  
   → Produces all possible combinations (Cartesian product).  
   Example: Every employee with every department.

6️⃣ SELF JOIN  
   → Joins a table with itself.
   Example: Compare employees with higher or lower salaries within same table.

---

🔹 3. Why Use Joins?
✅ Combine data from multiple related tables  
✅ Avoid data duplication  
✅ Enable complex reporting and analysis  

---

🔹 4. Common Real-world Example:
In a company database:
- `Departments` table stores department names.
- `Employees` table stores employee details.
- `Projects` table stores project information.

By using JOINs, you can link them together to show:
Employee → Department → Project relationships.

================================================================================
💻 PRACTICE SECTION
================================================================================
*/

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

