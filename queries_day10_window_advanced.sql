-- =============================================================
-- ?? DAY 10 – ADVANCED WINDOW FUNCTIONS (SQL Server Version)
-- Week 1: SQL Basics ? Day 10
-- Author: Tanuja Mannem
-- Description:
--   Learn advanced window functions for ranking,
--   moving averages, and cumulative analytics.
-- =============================================================

-- ?? Drop if exists (for re-runs)
DROP TABLE IF EXISTS Sales;
GO

-- ?? Create sample table
CREATE TABLE Sales (
    SaleID INT IDENTITY(1,1) PRIMARY KEY,
    EmpName VARCHAR(50),
    Region VARCHAR(30),
    SaleDate DATE,
    Amount DECIMAL(10,2)
);
GO

-- ?? Insert sample data
INSERT INTO Sales (EmpName, Region, SaleDate, Amount) VALUES
('Alice', 'North', '2024-01-01', 5000),
('Alice', 'North', '2024-01-03', 7000),
('Alice', 'North', '2024-01-05', 6500),
('Bob', 'South', '2024-01-02', 6000),
('Bob', 'South', '2024-01-04', 7500),
('Charlie', 'East', '2024-01-01', 8000),
('Charlie', 'East', '2024-01-03', 8200),
('Divya', 'West', '2024-01-05', 4000),
('Farhan', 'South', '2024-01-06', 7200);
GO

-- =============================================================
-- 1?? ROW_NUMBER(), RANK(), DENSE_RANK()
-- =============================================================
SELECT 
    EmpName,
    Amount,
    ROW_NUMBER() OVER (ORDER BY Amount DESC) AS RowNum,
    RANK() OVER (ORDER BY Amount DESC) AS RankNum,
    DENSE_RANK() OVER (ORDER BY Amount DESC) AS DenseRank
FROM Sales;
GO

-- =============================================================
-- 2?? RANK BY REGION (PARTITION BY)
-- =============================================================
SELECT 
    EmpName,
    Region,
    Amount,
    RANK() OVER (PARTITION BY Region ORDER BY Amount DESC) AS RankInRegion
FROM Sales
ORDER BY Region, RankInRegion;
GO

-- =============================================================
-- 3?? CUMULATIVE TOTAL (RUNNING SUM)
-- =============================================================
SELECT 
    EmpName,
    SaleDate,
    Amount,
    SUM(Amount) OVER (PARTITION BY EmpName ORDER BY SaleDate) AS RunningTotal
FROM Sales
ORDER BY EmpName, SaleDate;
GO

-- =============================================================
-- 4?? MOVING AVERAGE (SLIDING WINDOW)
-- =============================================================
SELECT 
    EmpName,
    SaleDate,
    Amount,
    ROUND(AVG(Amount) OVER (
        PARTITION BY EmpName 
        ORDER BY SaleDate 
        ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
    ), 2) AS MovingAvg
FROM Sales
ORDER BY EmpName, SaleDate;
GO

-- =============================================================
-- 5?? DIFFERENCE FROM PREVIOUS SALE (LAG)
-- =============================================================
SELECT 
    EmpName,
    SaleDate,
    Amount,
    LAG(Amount, 1) OVER (PARTITION BY EmpName ORDER BY SaleDate) AS PrevSale,
    Amount - LAG(Amount, 1) OVER (PARTITION BY EmpName ORDER BY SaleDate) AS Diff
FROM Sales
ORDER BY EmpName, SaleDate;
GO

-- =============================================================
-- 6?? LEADERBOARD CHALLENGE
-- =============================================================
SELECT *
FROM (
    SELECT 
        EmpName,
        Region,
        Amount,
        RANK() OVER (PARTITION BY Region ORDER BY Amount DESC) AS RankInRegion
    FROM Sales
) ranked
WHERE RankInRegion = 1;
GO

-- ? END OF DAY 10
-- Key Learnings:
-- - Used PARTITION BY for grouped analytics
-- - Calculated running totals & moving averages
-- - Compared current vs previous using LAG()
-- - Built a leaderboard query
