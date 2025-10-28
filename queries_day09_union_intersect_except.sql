-- =============================================
--   Topic: UNION, INTERSECT, and EXCEPT
--   Day 9 – Intermediate SQL
--   Author: Tanuja Mannem
--   Focus: Combining and comparing multiple query results
-- =============================================

/*
================================================================================
 THEORY SECTION
================================================================================

🔹 1. What are Set Operators?
Set operators are used to combine results from two or more SELECT statements.
They allow us to merge, compare, or filter rows between different result sets.

Each SELECT must:
- Return the same number of columns
- Have compatible data types
- Be in the same order

📌 Common SQL Set Operators:
----------------------------------------
1️⃣ UNION  
2️⃣ UNION ALL  
3️⃣ INTERSECT  
4️⃣ EXCEPT (also known as MINUS in Oracle)
----------------------------------------

---

🔹 2. Detailed Explanation

1️⃣ UNION  
➡ Combines results from multiple SELECT queries  
➡ Removes duplicate rows automatically  
✅ Common Use: To merge data from different sources without duplication

Example:
SELECT EmpName FROM Employees_A
UNION
SELECT EmpName FROM Employees_B;

---

2️⃣ UNION ALL  
➡ Similar to UNION but **keeps duplicates**  
✅ Common Use: To analyze full data including repeated entries

Example:
SELECT EmpName FROM Employees_A
UNION ALL
SELECT EmpName FROM Employees_B;

---

3️⃣ INTERSECT  
➡ Returns only the rows that are **common to both queries**  
🚫 Not supported directly in MySQL  
✅ MySQL Alternative: Use INNER JOIN with matching conditions

Example (MySQL Style):
SELECT a.EmpName, a.Dept
FROM Employees_A a
INNER JOIN Employees_B b
ON a.EmpName = b.EmpName AND a.Dept = b.Dept;

---

4️⃣ EXCEPT  
➡ Returns rows from the first query that are **not present in the second**  
🚫 Not supported directly in MySQL  
✅ MySQL Alternative: Use LEFT JOIN + WHERE NULL

Example (MySQL Style):
SELECT a.EmpName, a.Dept
FROM Employees_A a
LEFT JOIN Employees_B b
ON a.EmpName = b.EmpName AND a.Dept = b.Dept
WHERE b.EmpName IS NULL;

---

🔹 3. Real-world Use Cases
✅ Combining employee lists from two systems (UNION)  
✅ Identifying duplicate records (UNION ALL)  
✅ Finding common customers between campaigns (INTERSECT)  
✅ Identifying new or missing entries in one list (EXCEPT)

================================================================================
💻 PRACTICE SECTION
================================================================================
*/

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
--  1. UNION
-- Combines results & removes duplicates
SELECT EmpName, Dept FROM Employees_A
UNION
SELECT EmpName, Dept FROM Employees_B;

-- =============================================
--  2. UNION ALL
-- Combines results & keeps duplicates
SELECT EmpName, Dept FROM Employees_A
UNION ALL
SELECT EmpName, Dept FROM Employees_B;

-- =============================================
--  3. INTERSECT (MySQL alternative using INNER JOIN)
-- Returns only common records
SELECT a.EmpName, a.Dept
FROM Employees_A a
INNER JOIN Employees_B b
ON a.EmpName = b.EmpName AND a.Dept = b.Dept;

-- =============================================
--  4. EXCEPT (MySQL alternative using LEFT JOIN)
-- Returns records in A but not in B
SELECT a.EmpName, a.Dept
FROM Employees_A a
LEFT JOIN Employees_B b
ON a.EmpName = b.EmpName AND a.Dept = b.Dept
WHERE b.EmpName IS NULL;

-- =============================================
--  Challenge Queries
-- =============================================
-- 1. Find employees who are new in list B (not in A)
SELECT b.EmpName, b.Dept
FROM Employees_B b
LEFT JOIN Employees_A a
ON a.EmpName = b.EmpName AND a.Dept = b.Dept
WHERE a.EmpName IS NULL;

-- 2. Find total distinct employees across both lists
SELECT COUNT(*) AS TotalEmployees
FROM (
    SELECT EmpName FROM Employees_A
    UNION
    SELECT EmpName FROM Employees_B
) t;

