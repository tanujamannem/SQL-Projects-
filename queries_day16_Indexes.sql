-- =============================================================
--  DAY 16 – INDEXES & PERFORMANCE OPTIMIZATION
--  Author: Tanuja Mannem
--  Description:
--     Learn about indexes, clustered/non-clustered types,
--     how they improve query performance, and how to analyze
--     execution plans.
-- =============================================================

-- =============================================================
--  THEORY
-- =============================================================

-- What are Indexes?
-- -------------------------------------------------------------
-- Indexes are special lookup tables that SQL Server uses
-- to speed up data retrieval. They work like an index in a book —
-- instead of scanning the entire table, SQL can go directly
-- to the relevant rows.

-- Types of Indexes:
-- 1. Clustered Index
--     - Physically sorts and stores the rows in the table.
--     - Each table can have only ONE clustered index.
--     - Default on PRIMARY KEY columns.
--
-- 2. Non-Clustered Index
--     - Creates a separate structure that points to the data.
--     - You can have multiple non-clustered indexes.
--
-- Syntax:
--     CREATE CLUSTERED INDEX index_name ON table_name(column);
--     CREATE NONCLUSTERED INDEX index_name ON table_name(column);

-- Benefits of Indexes:
--  Faster SELECT queries.
--  Useful in JOINs, WHERE, ORDER BY clauses.
--
-- Drawbacks:
--  Slower INSERT/UPDATE/DELETE because index must also update.
--  Takes extra storage space.


-- =============================================================
--  CLEAN START
-- =============================================================
DROP TABLE IF EXISTS Sales;
GO

CREATE TABLE Sales (
    SaleID INT PRIMARY KEY IDENTITY(1,1),
    CustomerName VARCHAR(50),
    ProductName VARCHAR(50),
    Quantity INT,
    Price DECIMAL(10,2),
    SaleDate DATE
);
GO

INSERT INTO Sales (CustomerName, ProductName, Quantity, Price, SaleDate)
VALUES
('Amit', 'Laptop', 2, 80000, '2023-01-15'),
('Bhavna', 'Mouse', 5, 500, '2023-02-10'),
('Chirag', 'Keyboard', 3, 1000, '2023-03-05'),
('Divya', 'Laptop', 1, 85000, '2023-04-18'),
('Esha', 'Monitor', 2, 15000, '2023-05-20'),
('Farhan', 'Mouse', 10, 450, '2023-06-10'),
('Gaurav', 'Monitor', 3, 14500, '2023-07-25'),
('Harini', 'Laptop', 1, 90000, '2023-08-01');
GO


-- =============================================================
--  CLUSTERED INDEX
-- =============================================================

-- Clustered index automatically exists on PRIMARY KEY (SaleID)
-- Let’s verify:
EXEC sp_helpindex 'Sales';
GO

-- Query without filtering
SELECT * FROM Sales;

-- Query with filter using clustered index column
SELECT * FROM Sales WHERE SaleID = 5;


-- =============================================================
--  NON-CLUSTERED INDEX
-- =============================================================

-- Create a non-clustered index on ProductName
CREATE NONCLUSTERED INDEX idx_ProductName
ON Sales(ProductName);
GO

-- Verify
EXEC sp_helpindex 'Sales';
GO

-- Query using the indexed column
SELECT * FROM Sales WHERE ProductName = 'Laptop';
GO


-- =============================================================
--  COMPOSITE INDEX
-- =============================================================

-- Index on multiple columns
CREATE NONCLUSTERED INDEX idx_Product_Customer
ON Sales(ProductName, CustomerName);
GO


-- =============================================================
--  DROPPING AN INDEX
-- =============================================================

-- Drop index (syntax)
DROP INDEX idx_ProductName ON Sales;
GO


-- =============================================================
--  PERFORMANCE CHECK (EXPLAIN PLAN)
-- =============================================================

-- In SQL Server, you can use:
--     SET SHOWPLAN_TEXT ON;
--     SET SHOWPLAN_ALL ON;
--     SET STATISTICS IO ON;
-- to analyze how SQL optimizes your queries.

-- Example:
SET STATISTICS IO ON;
SELECT * FROM Sales WHERE ProductName = 'Monitor';
SET STATISTICS IO OFF;
GO


-- =============================================================
--  CHALLENGE QUERIES
-- =============================================================

-- 1. Create an index on SaleDate and run a query filtering by date.
CREATE NONCLUSTERED INDEX idx_SaleDate
ON Sales(SaleDate);

SELECT * FROM Sales WHERE SaleDate > '2023-04-01';


-- 2. Create a composite index on (CustomerName, ProductName)
CREATE NONCLUSTERED INDEX idx_Customer_Product
ON Sales(CustomerName, ProductName);


-- 3. Drop an index and observe performance impact.
DROP INDEX idx_Customer_Product ON Sales;


-- 4. Use an index to sort data faster.
SELECT * FROM Sales ORDER BY ProductName;


-- 5. View all existing indexes again.
EXEC sp_helpindex 'Sales';
GO


-- =============================================================
--  END OF DAY 16
--  Key Learnings:
--   Understood clustered vs non-clustered indexes
--   Created single & composite indexes
--   Checked index impact using STATISTICS IO
--  Practiced dropping and optimizing indexes
-- =============================================================

