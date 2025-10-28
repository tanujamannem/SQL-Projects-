-- =============================================
--  SQL PRACTICE: DAY 9 – UNION, INTERSECT, EXCEPT
-- Combines results from multiple queries
-- =============================================

DROP TABLE IF EXISTS Employees_A;
DROP TABLE IF EXISTS Employees_B;

CREATE TABLE Employees_A (
    EmpID INT,
    EmpName VARCHAR(50),
    Dept VARCHAR(50)
);

CREATE TABLE Employees_B (
    EmpID INT,
    EmpName VARCHAR(50),
    Dept VARCHAR(50)
);

INSERT INTO Employees_A VALUES
(101, 'Alice', 'HR'),
(102, 'Bob', 'Finance'),
(103, 'Charlie', 'IT'),
(104, 'David', 'Finance');

INSERT INTO Employees_B VALUES
(103, 'Charlie', 'IT'),
(104, 'David', 'Finance'),
(105, 'Eva', 'HR'),
(106, 'Farhan', 'Marketing');

-- =============================================
--  1?. UNION
-- Combines results & removes duplicates
SELECT EmpName, Dept FROM Employees_A
UNION
SELECT EmpName, Dept FROM Employees_B;

-- =============================================
--  2?. UNION ALL
-- Combines results & keeps duplicates
SELECT EmpName, Dept FROM Employees_A
UNION ALL
SELECT EmpName, Dept FROM Employees_B;

-- =============================================
--  3?. INTERSECT (MySQL alternative using INNER JOIN)
-- Returns only common records
SELECT a.EmpName, a.Dept
FROM Employees_A a
INNER JOIN Employees_B b
ON a.EmpName = b.EmpName AND a.Dept = b.Dept;

-- =============================================
--  4?. EXCEPT (MySQL alternative using LEFT JOIN)
-- Returns records in A but not in B
SELECT a.EmpName, a.Dept
FROM Employees_A a
LEFT JOIN Employees_B b
ON a.EmpName = b.EmpName AND a.Dept = b.Dept
WHERE b.EmpName IS NULL;

-- =============================================
--  Challenge Queries
-- =============================================
-- 1?. Find employees who are new in list B (not in A)
SELECT b.EmpName, b.Dept
FROM Employees_B b
LEFT JOIN Employees_A a
ON a.EmpName = b.EmpName AND a.Dept = b.Dept
WHERE a.EmpName IS NULL;

-- 2?. Find total distinct employees across both lists
SELECT COUNT(*) AS TotalEmployees
FROM (
    SELECT EmpName FROM Employees_A
    UNION
    SELECT EmpName FROM Employees_B
) t;
