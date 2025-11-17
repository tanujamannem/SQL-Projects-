-- =============================================================
--  SQL INTERVIEW PREPARATION – COMPLETE GUIDE
-- Author: Tanuja Mannem
-- Description:
--   Comprehensive SQL interview notes and practice.
--   Includes 150 theory questions with clear explanations,
--   and 60 practical queries with answers.
-- =============================================================

-- =============================================================
--  SECTION 1 – THEORY QUESTIONS 
-- =============================================================

-- =============================================================
--  SQL BASICS
-- =============================================================

1. What is SQL?
-- SQL (Structured Query Language) is a standard language used to store,
-- manipulate, and retrieve data from relational databases like SQL Server,
-- MySQL, Oracle, PostgreSQL, etc.

2. What are the different types of SQL statements?
-- SQL statements are categorized as:
-- 1. DDL – Data Definition Language (CREATE, ALTER, DROP, TRUNCATE)
-- 2. DML – Data Manipulation Language (SELECT, INSERT, UPDATE, DELETE)
-- 3. DCL – Data Control Language (GRANT, REVOKE)
-- 4. TCL – Transaction Control Language (COMMIT, ROLLBACK, SAVEPOINT)

3. What is the difference between SQL and MySQL?
-- SQL is the language used for database operations.
-- MySQL is a database management system (DBMS) that uses SQL to query data.

4. What is a database?
-- A database is an organized collection of data stored and accessed electronically.
-- Example: HR database, Sales database.

5. What is a table in SQL?
-- A table is a collection of related data entries arranged in rows and columns.
-- Each row represents a record; each column represents a field.

6. What are constraints in SQL?
-- Constraints are rules applied to table columns to ensure data integrity.
-- Common constraints:
-- - PRIMARY KEY
-- - FOREIGN KEY
-- - UNIQUE
-- - NOT NULL
-- - CHECK
-- - DEFAULT

7. What is a primary key?
-- A column (or set of columns) that uniquely identifies each row in a table.
-- Example:
-- CREATE TABLE Employees (EmpID INT PRIMARY KEY, Name VARCHAR(50));

8. What is a foreign key?
-- A column that establishes a relationship between two tables.
-- It refers to the primary key in another table.
-- Example:
-- FOREIGN KEY (DeptID) REFERENCES Departments(DeptID);

9. What is a composite key?
-- A key made up of two or more columns that uniquely identify a record.

10. What is normalization?
-- Process of organizing data to reduce redundancy and improve data integrity.
-- Normal forms:
-- 1NF – Eliminate repeating groups.
-- 2NF – Eliminate partial dependency.
-- 3NF – Eliminate transitive dependency.
-- BCNF (Boyce-Codd Normal Form) – Stronger version of 3NF.

-- =============================================================
--  INTERMEDIATE SQL
-- =============================================================

11. What is a JOIN? Explain types.
-- A JOIN combines data from multiple tables using related columns.
-- Types:
-- - INNER JOIN : Returns only matching rows.
-- - LEFT JOIN : All from left + matching from right.
-- - RIGHT JOIN : All from right + matching from left.
-- - FULL JOIN : All rows when there is a match in either table.
-- - CROSS JOIN : Cartesian product of two tables.
-- - SELF JOIN : Join table with itself.

12. What is the difference between WHERE and HAVING?
-- WHERE filters rows before aggregation.
-- HAVING filters groups after aggregation.

13. What is the difference between UNION and UNION ALL?
-- UNION : Combines results with select statements and removes duplicates.
-- UNION ALL : Combines results with select statements without removing duplicates.

14. What is a subquery?
-- A query inside another query.
-- Types:
-- - Single-row subquery
-- - Multi-row subquery
-- - Correlated subquery

15. What are CTEs (Common Table Expressions)?
-- Temporary result sets defined using WITH clause.
-- Useful for simplifying complex queries or recursive operations.

16. What is the difference between CTE and subquery?
-- CTE improves readability and can be reused multiple times.
-- Subquery is inline and cannot be reused.

17. What are window functions?
-- Functions that perform calculations across sets of rows related to the current row.
-- Examples:
-- ROW_NUMBER(), RANK(), DENSE_RANK(), LAG(), LEAD(), SUM() OVER()

18. What is the difference between RANK() and DENSE_RANK()?
-- RANK() leaves gaps in ranking.
-- DENSE_RANK() does not leave gaps.

19. What are indexes in SQL?
-- Indexes speed up data retrieval operations.
-- Types:
-- - Clustered Index: Sorts and stores rows physically.
-- - Non-clustered Index: Creates a separate structure for quick lookup.

20. What is a view?
-- A virtual table based on a SQL query.
-- Example:
-- CREATE VIEW ActiveEmployees AS 
--SELECT * FROM Employees WHERE Status='Active';

21. What are temporary tables?
-- Tables created for temporary data storage.
-- Local temp : #TempTable (session-specific)
-- Global temp :##TempTable (visible to all sessions)

22. What are derived tables?
-- subqueries in the FROM clause.
-- Example:
-- SELECT * FROM 
--(SELECT EmpID, Salary FROM Employees) AS Temp;

23. What are stored procedures?
-- Precompiled SQL blocks used to perform operations.
-- Example:
-- CREATE PROCEDURE GetAllEmployees AS 
--SELECT * FROM Employees;

24. What are functions?
-- Return a single value and can be used inside SELECT statements.
-- Example:
-- CREATE FUNCTION GetBonus(@sal DECIMAL) RETURNS DECIMAL AS BEGIN RETURN @sal * 0.1 END;

25. What are triggers?
-- Special stored procedures that execute automatically in response to an event.
-- Types:
-- - DML Trigger (AFTER, INSTEAD OF)
-- - DDL Trigger (on CREATE/DROP/ALTER)
-- - LOGON Trigger

26. What are transactions?
-- Logical units of work performed on a database.
-- Controlled by:
-- COMMIT, ROLLBACK, SAVEPOINT.

27. What is ACID property?
-- Ensures data integrity, prevents partial updates,
-- and keeps database reliable during failures.
-- A – Atomicity : All or nothing (complete or rollback)
-- C – Consistency : Maintains valid database state
-- I – Isolation : Each transaction runs independently
-- D – Durability : Committed data is permanent

28. What are constraints and their types?
-- Rules applied to ensure valid data.
-- Types: PRIMARY KEY, FOREIGN KEY, UNIQUE, CHECK, DEFAULT, NOT NULL

29. What are performance optimization techniques in SQL?
-- - Use indexes wisely
-- - Avoid SELECT *
-- - Use EXISTS instead of IN
-- - Limit subqueries
-- - Use proper joins

30. What is the difference between trigger and stored procedure?
-- Trigger : automatic, can’t be called manually.
-- Procedure : manually invoked.

-- =============================================================
--  ADVANCED / INTERVIEW-LEVEL QUESTIONS
-- =============================================================

31. Difference between DELETE, TRUNCATE, DROP
-- DELETE : Removes data but keeps structure.
-- TRUNCATE : Removes all rows, resets identity.
-- DROP : Removes table structure completely.

32. What is difference between EXISTS and IN?
-- EXISTS checks for existence and stops after finding a match (faster).
-- IN compares all values in the list.

33. What is difference between INNER JOIN and LEFT JOIN?
-- INNER JOIN : Only matching rows.
-- LEFT JOIN : All rows from left + matching from right.

34. What is difference between correlated and non-correlated subquery?
-- Non-Correlated Subquery: Does not depend on the outer query.
-- Executes only once for the entire SQL statement.
-- Outer query uses the single result returned by the subquery.
-- Correlated Subquery: Depends on the outer query.
-- Executes once for every row of the outer query.
-- Inner query uses values from the outer query.

35. What is difference between CHAR and VARCHAR?
-- CHAR is fixed-length; VARCHAR is variable-length.

36. Difference between NVARCHAR and VARCHAR?
-- NVARCHAR supports Unicode (multi-language characters).

37. What is COALESCE?
-- Returns the first non-null value.
-- Example: SELECT COALESCE(NULL, NULL, 'Hello') : Hello

38. What is NULLIF?
-- Returns NULL if two expressions are equal.

39. What are aggregate functions?
-- SUM(), AVG(), COUNT(), MIN(), MAX()

40. Difference between COUNT(*) and COUNT(column)?
-- COUNT(*) counts all rows.
-- COUNT(column) ignores NULL values.

41. Explain CASE WHEN in SQL.
-- Used for conditional logic.
-- Example:
-- SELECT Name, CASE WHEN Salary > 50000 THEN 'High' ELSE 'Low' END AS Category FROM Employees;

42. What is a cursor?
-- Row-by-row processing mechanism.
-- Slower than set-based operations, used when looping is required.

43. What is the difference between GROUP BY and PARTITION BY?
-- GROUP BY : Aggregates rows into one per group.
-- PARTITION BY : Divides result set for window functions.

44. What is schema in SQL?
-- Logical container for database objects.

45. What is self join?
-- Joining a table with itself using aliases.

46. What is referential integrity?
-- Ensures foreign key values match primary key values in parent table.

47. What is difference between view and table?
-- Table stores data physically.
-- View is a saved query, virtual in nature.

48. What is difference between stored procedure and function?
-- Procedure: may not return value.
-- Function: must return a value.

49. How to find duplicate rows in SQL?
-- SELECT column, COUNT(*) FROM table GROUP BY column HAVING COUNT(*) > 1;

50. How to find 2nd highest salary?
-- SELECT MAX(Salary) FROM Employees WHERE Salary < (SELECT MAX(Salary) FROM Employees);

51. What is a clustered index?
-- A clustered index determines the physical order of data in a table.
-- Each table can have only one clustered index because data is stored in that order.
-- Example:
-- CREATE CLUSTERED INDEX idx_EmpID ON Employees(EmpID);

52. What is a non-clustered index?
-- A non-clustered index stores index separately from the data.
-- It maintains pointers to the actual data rows.
-- Example:
-- CREATE NONCLUSTERED INDEX idx_EmpName ON Employees(EmpName);

53. What is the difference between clustered and non-clustered index?
-- Clustered: Sorts and stores actual data.
-- Non-clustered: Creates a separate structure with pointers to data.
-- A table can have only one clustered index but multiple non-clustered indexes.

54. What is a composite index?
-- An index created on multiple columns.
-- Example:
-- CREATE INDEX idx_Name_Dept ON Employees(EmpName, DeptID);

55. What is a covering index?
-- An index that contains all columns needed for a query.
-- The database doesn’t have to access the table data, only the index.

56. What is a filtered index?
-- An index created with a WHERE clause to improve performance for selective queries.
-- Example:
-- CREATE INDEX idx_HighSalary ON Employees(Salary) WHERE Salary > 70000;

57. What is an execution plan?
-- A report that shows how SQL Server executes a query.
-- Used to analyze and optimize performance using indexes and join strategies.

58. What is the difference between logical and physical reads?
-- Logical reads: Pages read from memory.
-- Physical reads: Pages read from disk (slower).

59. What is a view? Why is it used?
-- A view is a virtual table created from one or more tables.
-- Used to simplify complex queries and secure sensitive data.
-- Example:
-- CREATE VIEW ActiveEmployees AS SELECT EmpID, EmpName FROM Employees WHERE Status = 'Active';

60. What are materialized views?
-- Unlike normal views, materialized views store data physically.
-- They improve performance but require refresh when underlying data changes.

61. Can we update data through a view?
-- Yes, if the view is based on a single table without aggregations or DISTINCT.
-- Complex views (joins, aggregates) are usually not updatable.

62. What is an indexed view?
-- A view that has a unique clustered index, making it faster for large data aggregations.

63. What is the difference between view and temporary table?
-- View: Virtual, stored permanently in the database.
-- Temp Table: Physically created and deleted automatically after the session ends.

64. What is a trigger?
-- A special stored procedure that runs automatically when a specific event occurs.
-- Types: DML (AFTER/INSTEAD OF), DDL, LOGON.

65. What is a DML trigger?
-- Executes in response to DML events like INSERT, UPDATE, or DELETE.
-- Example:
-- CREATE TRIGGER trg_Audit ON Employees AFTER INSERT AS INSERT INTO AuditTable SELECT * FROM inserted;

66. What is an AFTER trigger?
-- Executes after the DML event is completed.
-- Used for auditing or enforcing business rules.

67. What is an INSTEAD OF trigger?
-- Executes instead of the triggering action.
-- Useful when updating complex views.

68. What is a DDL trigger?
-- Executes in response to CREATE, ALTER, DROP events.
-- Example:
-- CREATE TRIGGER trg_DropProtect ON DATABASE FOR DROP_TABLE AS PRINT('Table drop not allowed');

69. What is a logon trigger?
-- Fires when a user session is established.
-- Used for logging or restricting access.

70. What are stored procedures?
-- Precompiled SQL code that can accept parameters and perform actions.
-- Example:
-- CREATE PROCEDURE GetSalary @EmpID INT AS SELECT Salary FROM Employees WHERE EmpID = @EmpID;

71. What are advantages of stored procedures?
-- - Improved performance (precompiled)
-- - Reusability
-- - Security (control access)
-- - Easier maintenance

72. What are functions in SQL?
-- Reusable routines that return a single value or table.
-- Example:
-- CREATE FUNCTION GetBonus(@Salary DECIMAL) RETURNS DECIMAL AS BEGIN RETURN @Salary * 0.1 END;

73. Difference between stored procedure and function?
-- Procedure: Can return multiple values; used for DML.
-- Function: Must return a value; used in SELECT queries.

74. What are scalar and table-valued functions?
-- Scalar: Returns a single value.
-- Table-Valued: Returns a table as output.

75. Can a function modify table data?
-- No, functions cannot modify database state (no INSERT/UPDATE/DELETE inside).

76. What are transactions in SQL?
-- Logical units of work that ensure data integrity using COMMIT or ROLLBACK.

77. What are the ACID properties?
-- A – Atomicity: All or nothing.
-- C – Consistency: Maintains data integrity.
-- I – Isolation: Transactions don’t interfere with each other.
-- D – Durability: Once committed, changes are permanent.

78. What are isolation levels in SQL?
-- Control how transaction concurrency is handled.
-- Levels:
-- 1. Read Uncommitted
-- 2. Read Committed
-- 3. Repeatable Read
-- 4. Serializable
-- 5. Snapshot

79. What is a deadlock?
-- Occurs when two transactions hold locks on resources that each other need, causing a standstill.

80. How to prevent deadlocks?
-- - Access tables in same order.
-- - Keep transactions short.
-- - Use proper isolation level.

81. What is a savepoint?
-- A marker within a transaction to which you can rollback partially.
-- Example:
-- SAVE TRANSACTION Step1;

82. What is COMMIT and ROLLBACK?
-- COMMIT: Saves all changes permanently.
-- ROLLBACK: Reverts all uncommitted changes.

83. What is TRY...CATCH in SQL?
-- Used for error handling inside procedures or scripts.
-- Example:
-- BEGIN TRY ... END TRY BEGIN CATCH ... END CATCH

84. What are system functions in SQL?
-- Predefined functions like GETDATE(), LEN(), UPPER(), LOWER(), ROUND(), etc.

85. What are user-defined functions (UDF)?
-- Custom functions created by users to perform specific logic.

86. What is normalization?
-- Process of structuring data to minimize redundancy and dependency.

87. Explain 1NF, 2NF, 3NF, and BCNF.
-- 1NF: Remove repeating groups.
-- 2NF: Remove partial dependency.
-- 3NF: Remove transitive dependency.
-- BCNF: Each determinant is a candidate key.

88. What is denormalization?
-- The process of combining tables to improve query performance by reducing joins.

89. What are anomalies in database design?
-- Insertion, Update, and Deletion anomalies that occur due to poor normalization.

90. What are constraints? Why are they important?
-- Rules that enforce data validity and integrity.
-- Examples: PRIMARY KEY, FOREIGN KEY, CHECK, UNIQUE.

91. What are the differences between CHECK and DEFAULT constraint?
-- CHECK validates column values.
-- DEFAULT provides a value when none is specified.

92. What is referential integrity constraint?
-- Ensures foreign key values in one table match primary key values in another.

93. What is cascading in foreign keys?
-- ON DELETE CASCADE / ON UPDATE CASCADE automatically updates or deletes dependent rows.

94. What is the difference between DELETE CASCADE and SET NULL?
-- DELETE CASCADE removes child rows.
-- SET NULL makes foreign key columns NULL when parent is deleted.

95. What is a schema?
-- A logical grouping of database objects (tables, views, etc.) under one namespace.

96. What are roles in SQL?
-- Predefined groups that define permissions for users.
-- Example: db_datareader, db_datawriter, db_owner.

97. What is GRANT and REVOKE?
-- GRANT: Gives permissions.
-- REVOKE: Removes permissions.
-- Example:
-- GRANT SELECT ON Employees TO User1;

98. What is encryption in SQL?
-- Technique to protect sensitive data at rest or in transit.
-- Example: Transparent Data Encryption (TDE).

99. What is query optimization?
-- The process by which SQL Server chooses the most efficient way to execute a query using indexes, joins, and execution plans.

100. What are database statistics?
-- Metadata used by SQL optimizer to choose efficient execution plans.
-- Up-to-date statistics improve query performance.

-- =============================================================
--  PERFORMANCE TUNING & OPTIMIZATION
-- =============================================================

101. What is a query optimizer?
-- A component of the SQL engine that determines the most efficient way to execute a query.
-- It evaluates multiple execution plans and selects the one with lowest cost.

102. What is a query execution plan?
-- It shows the path taken by the SQL engine to fetch data.
-- Can be viewed using “Display Estimated Execution Plan” or “Include Actual Execution Plan”.

103. What is a query hint?
-- A directive that overrides the default behavior of the optimizer.
-- Example: SELECT * FROM Employees WITH (NOLOCK);

104. What is a table scan?
-- When SQL Server reads all rows of a table to find relevant data.
-- Occurs when no useful index is available.

105. What is an index seek?
-- When the query uses an index to quickly locate data rows.
-- Much faster than a table scan.

106. What is an index scan?
-- The entire index is read to find results — still faster than a table scan, but slower than an index seek.

107. What are statistics in SQL Server?
-- They store data distribution information to help the optimizer choose the best plan.

108. What happens if statistics are outdated?
-- Query performance degrades because the optimizer uses incorrect assumptions.

109. How to update statistics?
-- Use the command: UPDATE STATISTICS TableName;

110. What is fragmentation in indexes?
-- Occurs when data pages become scattered due to frequent INSERT, UPDATE, DELETE.
-- Leads to slower performance.

111. How to fix index fragmentation?
-- Use REBUILD (complete) or REORGANIZE (light) commands:
-- ALTER INDEX idx_Name ON Employees REBUILD;

112. What is fill factor in indexing?
-- Defines how full the index page should be when created.
-- Lower fill factor leaves free space for future inserts, reducing fragmentation.

113. What is parameter sniffing?
-- When SQL Server caches a plan for a specific parameter and reuses it even if it’s not optimal for later executions.

114. How to fix parameter sniffing?
-- Use OPTIMIZE FOR UNKNOWN or recompile query:
-- OPTION (RECOMPILE);

115. What is plan caching?
-- SQL Server stores compiled execution plans in memory to reuse for future queries, improving performance.

116. What is a plan cache bloat?
-- Occurs when too many unique queries are executed, filling cache with unneeded plans.

117. How to view current execution plans in cache?
-- SELECT * FROM sys.dm_exec_cached_plans;

118. What is the difference between TEMPDB and user databases?
-- TEMPDB is a system database used for temporary objects, sorting, and intermediate results.

119. How can TEMPDB impact performance?
-- Heavy use of temp tables, table variables, or sorting operations can slow down performance.

120. What is a memory grant?
-- The amount of memory allocated to a query during execution for sorting and hashing operations.

-- =============================================================
--  ADVANCED INDEXING & STORAGE
-- =============================================================

121. What is a unique index?
-- Ensures all values in the indexed column are distinct.
-- Automatically created with PRIMARY KEY or UNIQUE constraints.

122. What is a bitmap index?
-- Used in analytical databases (not SQL Server OLTP) — stores bitmaps for column values to speed up queries.

123. What is a columnstore index?
-- Stores data in a columnar format instead of row-based.
-- Greatly improves performance for analytics and aggregation workloads.

124. What is the difference between rowstore and columnstore?
-- Rowstore: Optimized for OLTP (frequent reads/writes).
-- Columnstore: Optimized for OLAP (large aggregations and scans).

125. What is a filtered index and when to use it?
-- An index created on a subset of rows.
-- Example: CREATE INDEX idx_ActiveEmp ON Employees(Status) WHERE Status = 'Active';

126. What is index selectivity?
-- The ratio of unique values to total rows. Higher selectivity → better index performance.

127. What is index density?
-- Measure of duplicate values in an index; higher density = less selective.

128. What is a heap table?
-- A table without a clustered index. Data is stored unordered.
-- Can lead to slower queries compared to indexed tables.

129. What is page splitting?
-- Occurs when inserting a new row into a full data page.
-- SQL Server moves part of the data to a new page → causes fragmentation.

130. How to reduce page splits?
-- Use proper fill factor and choose appropriate clustered index keys.

-- =============================================================
--  SECURITY & AUTHORIZATION
-- =============================================================

131. What is authentication in SQL Server?
-- The process of verifying user identity.
-- Two modes: Windows Authentication and SQL Server Authentication.

132. What is authorization?
-- Determines what actions a user can perform once authenticated.

133. What is SQL injection?
-- A code injection attack that manipulates SQL queries through user input.

134. How to prevent SQL injection?
-- Use parameterized queries or stored procedures.
-- Example:
-- SELECT * FROM Employees WHERE EmpID = @EmpID;

135. What are roles in SQL?
-- Roles are permission containers.
-- Example: GRANT SELECT TO db_datareader;

136. What is row-level security (RLS)?
-- Restricts data access for users based on filters.
-- Implemented using security predicates and inline table-valued functions.

137. What is data masking?
-- Hides sensitive data from unauthorized users.
-- Example: ALTER TABLE Employees ALTER COLUMN SSN ADD MASKED WITH (FUNCTION = 'partial(0,"XXX-XX-",4)');

138. What is encryption at rest vs encryption in transit?
-- At rest: Encrypts stored data (TDE).
-- In transit: Encrypts data during transmission (SSL/TLS).

139. What is Transparent Data Encryption (TDE)?
-- Encrypts entire database files to protect data from unauthorized access at the storage level.

140. What is Always Encrypted?
-- Encrypts specific sensitive columns using client-side encryption keys.

-- =============================================================
--  ADVANCED CONCEPTS & TRICKY QUESTIONS
-- =============================================================

141. What is the difference between UNION and UNION ALL?
-- UNION removes duplicates.
-- UNION ALL keeps duplicates (faster).

142. What is COALESCE() used for?
-- Returns the first non-null value in a list.
-- Example: SELECT COALESCE(MiddleName, 'N/A');

143. What is NULLIF() function?
-- Returns NULL if two expressions are equal.
-- Example: SELECT NULLIF(5,5); → NULL

144. What is CROSS APPLY?
-- Similar to INNER JOIN but allows joining with table-valued functions for each row.

145. What is OUTER APPLY?
-- Similar to LEFT JOIN with table-valued functions — returns all left rows even if no match.

146. What is a recursive CTE?
-- A Common Table Expression that references itself to process hierarchical data (like org charts).

147. What are window functions?
-- Functions like ROW_NUMBER(), RANK(), LAG(), LEAD() that perform calculations across sets of rows.

148. What is the difference between RANK(), DENSE_RANK(), and ROW_NUMBER()?
-- RANK(): Skips numbers on ties.
-- DENSE_RANK(): No gaps.
-- ROW_NUMBER(): Unique sequence always.

149. What are aggregate vs analytic functions?
-- Aggregate: Summarize across groups (SUM, AVG).
-- Analytic: Compute values across a window of rows (OVER clause).

150. What are best practices for writing efficient SQL queries?
-- ✅ Use proper indexes  
-- ✅ Avoid SELECT *  
-- ✅ Use joins wisely  
-- ✅ Keep transactions short  
-- ✅ Update statistics regularly  
-- ✅ Avoid cursors for large data  
-- ✅ Analyze execution plans  


-- =============================================================
--  SECTION 2 – PRACTICAL SQL QUERIES (WITH ANSWERS)
-- =============================================================

-- Sample dataset
CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50),
    DeptID INT,
    Salary DECIMAL(10,2),
    HireDate DATE
);

CREATE TABLE Departments (
    DeptID INT PRIMARY KEY,
    DeptName VARCHAR(50)
);

INSERT INTO Departments VALUES
(1,'HR'),(2,'Finance'),(3,'IT'),(4,'Sales');

INSERT INTO Employees VALUES
(1,'Amit',1,45000,'2021-02-10'),
(2,'Bhavna',2,60000,'2020-06-20'),
(3,'Chirag',3,75000,'2019-08-12'),
(4,'Divya',3,90000,'2023-03-01'),
(5,'Esha',4,52000,'2022-10-05');

-- 1. Find employees earning more than 60000
SELECT EmpName, Salary FROM Employees WHERE Salary > 60000;

-- 2. Find average salary department-wise
SELECT DeptID, AVG(Salary) AS AvgSal FROM Employees GROUP BY DeptID;

-- 3. Find employees with salary > average salary
SELECT EmpName, Salary FROM Employees
WHERE Salary > (SELECT AVG(Salary) FROM Employees);

-- 4. Find top 3 highest-paid employees
SELECT TOP 3 EmpName, Salary FROM Employees ORDER BY Salary DESC;

-- 5. Find second highest salary
SELECT MAX(Salary) FROM Employees
WHERE Salary < (SELECT MAX(Salary) FROM Employees);

-- 6. Count employees in each department
SELECT DeptID, COUNT(*) AS TotalEmp FROM Employees GROUP BY DeptID;

-- 7. Find employees who joined in 2023
SELECT * FROM Employees WHERE YEAR(HireDate)=2023;

-- 8. Create a view for employees above 60k
CREATE VIEW HighSalaryEmp AS SELECT * FROM Employees WHERE Salary>60000;

-- 9. Create CTE for top earners
WITH TopEarners AS (
  SELECT EmpName, Salary, ROW_NUMBER() OVER(ORDER BY Salary DESC) AS rn
  FROM Employees
)
SELECT * FROM TopEarners WHERE rn<=3;

-- 10. Find employees and their departments using join
SELECT e.EmpName, d.DeptName FROM Employees e
JOIN Departments d ON e.DeptID=d.DeptID;

-- 11. Find employees whose salary is between 50,000 and 80,000
SELECT EmpName, Salary
FROM Employees
WHERE Salary BETWEEN 50000 AND 80000;

-- 12. Find employees whose names start with 'D'
SELECT * FROM Employees WHERE EmpName LIKE 'D%';

-- 13. Find employees not belonging to IT department
SELECT * FROM Employees
WHERE DeptID <> (SELECT DeptID FROM Departments WHERE DeptName='IT');

-- 14. Get employees hired in the last 2 years
SELECT EmpName, HireDate
FROM Employees
WHERE HireDate >= DATEADD(YEAR, -2, GETDATE());

-- 15. Show total salary paid in each department
SELECT d.DeptName, SUM(e.Salary) AS TotalSalary
FROM Employees e
JOIN Departments d ON e.DeptID = d.DeptID
GROUP BY d.DeptName;

-- 16. Retrieve department name with highest average salary
SELECT TOP 1 d.DeptName, AVG(e.Salary) AS AvgSalary
FROM Employees e
JOIN Departments d ON e.DeptID = d.DeptID
GROUP BY d.DeptName
ORDER BY AvgSalary DESC;

-- 17. Find departments having more than 1 employee
SELECT DeptID, COUNT(*) AS TotalEmp
FROM Employees
GROUP BY DeptID
HAVING COUNT(*) > 1;

-- 18. Display employee details ordered by department and salary desc
SELECT EmpName, DeptID, Salary
FROM Employees
ORDER BY DeptID, Salary DESC;

-- 19. Get total number of employees in company
SELECT COUNT(*) AS TotalEmployees FROM Employees;

-- 20. Find employees with same salary (duplicates)
SELECT Salary, COUNT(*) AS Count
FROM Employees
GROUP BY Salary
HAVING COUNT(*) > 1;

-- 21. Increase salary by 10% for Finance department employees
UPDATE Employees
SET Salary = Salary * 1.10
WHERE DeptID = (SELECT DeptID FROM Departments WHERE DeptName='Finance');

-- 22. Delete employees from HR department
DELETE FROM Employees
WHERE DeptID = (SELECT DeptID FROM Departments WHERE DeptName='HR');

-- 23. Add a new column Bonus and update with 5% of Salary
ALTER TABLE Employees ADD Bonus DECIMAL(10,2);
UPDATE Employees SET Bonus = Salary * 0.05;
SELECT EmpName, Salary, Bonus FROM Employees;

-- 24. Find 3rd highest salary using OFFSET FETCH
SELECT EmpName, Salary
FROM Employees
ORDER BY Salary DESC
OFFSET 2 ROWS FETCH NEXT 1 ROWS ONLY;

-- 25. Use CASE to categorize employees
SELECT EmpName,
       CASE 
            WHEN Salary >= 80000 THEN 'High Earner'
            WHEN Salary BETWEEN 50000 AND 79999 THEN 'Mid Earner'
            ELSE 'Low Earner'
       END AS SalaryCategory
FROM Employees;

-- 26. Find employees who don’t belong to any department (if any)
SELECT * FROM Employees e
LEFT JOIN Departments d ON e.DeptID = d.DeptID
WHERE d.DeptID IS NULL;

-- 27. Create a temporary table for IT employees
SELECT * INTO #IT_Employees
FROM Employees
WHERE DeptID = (SELECT DeptID FROM Departments WHERE DeptName='IT');
SELECT * FROM #IT_Employees;

-- 28. Create a view for employees with bonus > 3000
CREATE VIEW HighBonus AS
SELECT EmpName, Salary, Bonus FROM Employees WHERE Bonus > 3000;

SELECT * FROM HighBonus;

-- 29. Create a CTE to get top 2 earners in each department
WITH DeptRank AS (
  SELECT EmpName, DeptID, Salary,
         ROW_NUMBER() OVER (PARTITION BY DeptID ORDER BY Salary DESC) AS rn
  FROM Employees
)
SELECT * FROM DeptRank WHERE rn <= 2;

-- 30. Find department-wise maximum and minimum salary
SELECT d.DeptName, MAX(e.Salary) AS MaxSal, MIN(e.Salary) AS MinSal
FROM Employees e
JOIN Departments d ON e.DeptID = d.DeptID
GROUP BY d.DeptName;

-- 31. Display all employees hired before 2022
SELECT * FROM Employees WHERE YEAR(HireDate) < 2022;

-- 32. Count how many employees joined each year
SELECT YEAR(HireDate) AS YearJoined, COUNT(*) AS TotalJoined
FROM Employees
GROUP BY YEAR(HireDate)
ORDER BY YearJoined;

-- 33. Find department with minimum total salary
SELECT TOP 1 d.DeptName, SUM(e.Salary) AS TotalSal
FROM Employees e
JOIN Departments d ON e.DeptID = d.DeptID
GROUP BY d.DeptName
ORDER BY TotalSal ASC;

-- 34. Display employees sorted by HireDate (oldest to newest)
SELECT EmpName, HireDate FROM Employees ORDER BY HireDate ASC;

-- 35. Calculate running total of salary by department
SELECT EmpName, DeptID,
       SUM(Salary) OVER (PARTITION BY DeptID ORDER BY Salary) AS RunningTotal
FROM Employees;

-- 36. Find average salary of company (rounded)
SELECT ROUND(AVG(Salary), 2) AS AvgSalary FROM Employees;

-- 37. Display department, total employees, and average salary
SELECT d.DeptName,
       COUNT(e.EmpID) AS TotalEmp,
       AVG(e.Salary) AS AvgSalary
FROM Employees e
JOIN Departments d ON e.DeptID = d.DeptID
GROUP BY d.DeptName;

-- 38. Find employees with name length > 5
SELECT EmpName FROM Employees WHERE LEN(EmpName) > 5;

-- 39. Create user-defined function to calculate annual salary
CREATE FUNCTION GetAnnualSalary(@sal DECIMAL(10,2))
RETURNS DECIMAL(10,2)
AS
BEGIN
  RETURN @sal * 12;
END;
GO

SELECT EmpName, Salary, dbo.GetAnnualSalary(Salary) AS AnnualSalary FROM Employees;

-- 40. Create a stored procedure to list employees by department
CREATE PROCEDURE GetEmpByDept @DeptName VARCHAR(50)
AS
BEGIN
  SELECT e.EmpName, d.DeptName, e.Salary
  FROM Employees e
  JOIN Departments d ON e.DeptID = d.DeptID
  WHERE d.DeptName = @DeptName;
END;
GO

EXEC GetEmpByDept 'IT';

-- 41. Create trigger to prevent deleting employees with salary > 80000
CREATE TRIGGER PreventHighSalaryDelete
ON Employees
INSTEAD OF DELETE
AS
BEGIN
  IF EXISTS (SELECT * FROM deleted WHERE Salary > 80000)
  BEGIN
    PRINT('? Cannot delete employees with salary greater than 80000');
    ROLLBACK TRANSACTION;
  END
  ELSE
  BEGIN
    DELETE FROM Employees WHERE EmpID IN (SELECT EmpID FROM deleted);
  END
END;

-- 42. Create audit table and trigger to log salary updates
CREATE TABLE Salary_Audit (
    EmpID INT,
    OldSalary DECIMAL(10,2),
    NewSalary DECIMAL(10,2),
    ChangeDate DATETIME DEFAULT GETDATE()
);

CREATE TRIGGER trg_SalaryAudit
ON Employees
AFTER UPDATE
AS
BEGIN
  INSERT INTO Salary_Audit (EmpID, OldSalary, NewSalary)
  SELECT d.EmpID, d.Salary, i.Salary
  FROM deleted d
  JOIN inserted i ON d.EmpID = i.EmpID;
END;

UPDATE Employees SET Salary = Salary + 5000 WHERE EmpID = 2;
SELECT * FROM Salary_Audit;

-- 43. Demonstrate transaction rollback
BEGIN TRANSACTION;
UPDATE Employees SET Salary = 20000 WHERE EmpID = 3;
ROLLBACK TRANSACTION;
SELECT * FROM Employees WHERE EmpID = 3;

-- 44. Demonstrate COMMIT transaction
BEGIN TRANSACTION;
UPDATE Employees SET Salary = Salary + 3000 WHERE EmpID = 5;
COMMIT;
SELECT * FROM Employees WHERE EmpID = 5;

-- 45. Create index on EmpName for faster search
CREATE INDEX idx_EmpName ON Employees(EmpName);

-- 46. Drop the index
DROP INDEX idx_EmpName ON Employees;

-- 47. Show top 2 earners in company using RANK()
SELECT EmpName, Salary, RANK() OVER (ORDER BY Salary DESC) AS rnk
FROM Employees
WHERE RANK() <= 2;

-- 48. Find employees who have the same department as ‘Bhavna’
SELECT e.EmpName
FROM Employees e
WHERE e.DeptID = (SELECT DeptID FROM Employees WHERE EmpName='Bhavna');

-- 49. Calculate percentage of salary per department
SELECT DeptID, EmpName,
       ROUND(Salary * 100.0 / SUM(Salary) OVER (PARTITION BY DeptID), 2) AS SalaryPercent
FROM Employees;

-- 50. Create trigger that prevents salary > 1,00,000
CREATE TRIGGER trg_SalaryLimit
ON Employees
FOR INSERT, UPDATE
AS
BEGIN
  IF EXISTS (SELECT * FROM inserted WHERE Salary > 100000)
  BEGIN
    PRINT('? Salary cannot exceed 1,00,000!');
    ROLLBACK TRANSACTION;
  END
END;

-- 51. Find employees earning the minimum salary
SELECT TOP 1 EmpName, Salary FROM Employees ORDER BY Salary ASC;

-- 52. Calculate difference between highest and lowest salary
SELECT MAX(Salary) - MIN(Salary) AS SalaryRange FROM Employees;

-- 53. Show total, average, min, and max salary in one query
SELECT COUNT(*) AS TotalEmp,
       AVG(Salary) AS AvgSal,
       MIN(Salary) AS MinSal,
       MAX(Salary) AS MaxSal
FROM Employee.

-- 54. Create a DDL trigger to log when a table is dropped
CREATE TABLE DDL_Audit (
    EventType NVARCHAR(100),
    ObjectName NVARCHAR(100),
    EventTime DATETIME
);
GO
CREATE TRIGGER trg_LogDDL
ON DATABASE
FOR DROP_TABLE
AS
BEGIN
  INSERT INTO DDL_Audit(EventType, ObjectName, EventTime)
  VALUES('DROP TABLE', EVENTDATA().value('(/EVENT_INSTANCE/ObjectName)[1]','NVARCHAR(100)'), GETDATE());
END;
GO

-- 55. Find all employees whose bonus > average bonus
SELECT EmpName, Bonus
FROM Employees
WHERE Bonus > (SELECT AVG(Bonus) FROM Employees);

-- 56. Retrieve top earner per department using DENSE_RANK
SELECT EmpName, DeptID, Salary
FROM (
  SELECT EmpName, DeptID, Salary,
         DENSE_RANK() OVER(PARTITION BY DeptID ORDER BY Salary DESC) AS rnk
  FROM Employees
) t
WHERE rnk = 1;

-- 57. Create function to return department name for given EmpID
CREATE FUNCTION GetDeptName(@EmpID INT)
RETURNS VARCHAR(50)
AS
BEGIN
  DECLARE @DeptName VARCHAR(50);
  SELECT @DeptName = d.DeptName
  FROM Employees e
  JOIN Departments d ON e.DeptID = d.DeptID
  WHERE e.EmpID = @EmpID;
  RETURN @DeptName;
END;
GO

SELECT EmpName, dbo.GetDeptName(EmpID) AS DeptName FROM Employees;

-- 58. Show employees earning above company average salary
SELECT EmpName, Salary
FROM Employees
WHERE Salary > (SELECT AVG(Salary) FROM Employees);

-- 59. List employee name, salary, and salary rank company-wide
SELECT EmpName, Salary,
       DENSE_RANK() OVER (ORDER BY Salary DESC) AS SalaryRank
FROM Employees;

-- 60. Clean up temporary and audit tables (optional)
DROP TABLE IF EXISTS #IT_Employees;
DROP TABLE IF EXISTS Salary_Audit;
DROP TABLE IF EXISTS DDL_Audit;








