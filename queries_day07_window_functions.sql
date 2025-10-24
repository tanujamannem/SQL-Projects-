-- ============================================
--  Topic: Window Functions
--  Day 7 - Intermediate SQL
--  Focus: Ranking, partitioning, cumulative totals
-- ============================================

-- Drop and recreate for clean start
DROP TABLE IF EXISTS sales;

CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    region VARCHAR(50),
    sale_amount DECIMAL(10,2),
    sale_date DATE
);

INSERT INTO sales (sale_id, emp_name, region, sale_amount, sale_date) VALUES
(1, 'Amit', 'North', 5000, '2024-01-01'),
(2, 'Bhavna', 'North', 7000, '2024-01-03'),
(3, 'Chirag', 'South', 8000, '2024-01-02'),
(4, 'Divya', 'South', 6000, '2024-01-05'),
(5, 'Esha', 'East', 4000, '2024-01-06'),
(6, 'Farhan', 'West', 3000, '2024-01-02'),
(7, 'Gauri', 'North', 9000, '2024-01-04'),
(8, 'Harish', 'South', 7000, '2024-01-07'),
(9, 'Isha', 'East', 6000, '2024-01-08'),
(10, 'Jay', 'West', 8500, '2024-01-03');

-- ============================================
--  1?. ROW_NUMBER() - unique ranking per partition
-- ============================================

-- Rank employees in each region by their sales amount
SELECT emp_name, region, sale_amount,
       ROW_NUMBER() OVER(PARTITION BY region ORDER BY sale_amount DESC) AS row_num
FROM sales;

-- ============================================
--  2?. RANK() - allows same rank for ties (skips numbers)
-- ============================================

SELECT emp_name, region, sale_amount,
       RANK() OVER(PARTITION BY region ORDER BY sale_amount DESC) AS rnk
FROM sales;

-- ============================================
--  3?. DENSE_RANK() - same rank for ties (no skip)
-- ============================================

SELECT emp_name, region, sale_amount,
       DENSE_RANK() OVER(PARTITION BY region ORDER BY sale_amount DESC) AS dense_rnk
FROM sales;

-- ============================================
--  4?. NTILE() - splits rows into equal groups (quartiles)
-- ============================================

SELECT emp_name, region, sale_amount,
       NTILE(4) OVER(ORDER BY sale_amount DESC) AS quartile
FROM sales;

-- ============================================
--  5?. SUM() OVER() - cumulative total
-- ============================================

SELECT emp_name, region, sale_amount, sale_date,
       SUM(sale_amount) OVER(ORDER BY sale_date) AS running_total
FROM sales;

-- ============================================
--  6?. AVG() OVER() with PARTITION BY
-- ============================================

SELECT emp_name, region, sale_amount,
       AVG(sale_amount) OVER(PARTITION BY region) AS avg_region_sale
FROM sales;

-- ============================================
--  7? .Combined Example
-- ============================================

-- Find top 2 salespeople by region
WITH RankedSales AS (
    SELECT emp_name, region, sale_amount,
           ROW_NUMBER() OVER(PARTITION BY region ORDER BY sale_amount DESC) AS rnk
    FROM sales
)
SELECT * FROM RankedSales WHERE rnk <= 2;

-- ============================================
--  Challenge Queries
-- ============================================

--  1. Find each employee’s sales rank across all regions.
SELECT emp_name, sale_amount,
       RANK() OVER(ORDER BY sale_amount DESC) AS overall_rank
FROM sales;

--  2. Calculate total sales per region and overall cumulative sales.
SELECT region, sale_amount,
       SUM(sale_amount) OVER(PARTITION BY region) AS region_total,
       SUM(sale_amount) OVER(ORDER BY region) AS cumulative_total
FROM sales;

--  3. Find top 3 sales transactions overall.
SELECT emp_name, region, sale_amount
FROM (
    SELECT emp_name, region, sale_amount,
           ROW_NUMBER() OVER(ORDER BY sale_amount DESC) AS rnk
    FROM sales
) t
WHERE rnk <= 3;
