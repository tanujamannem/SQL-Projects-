-- =====================================================================================
-- Topic: GROUP BY, HAVING
-- Author: Tanuja Mannem
-- Day: 3 - SQL Basics
-- Description: Aggregation and filtering groups using GROUP BY and HAVING in SQL Server
-- =====================================================================================

-- ================================= THEORY ============================================
-- 1. GROUP BY Clause:
--    - Used to group rows that have the same values in specified columns.
--    - Often used with aggregate functions: SUM, COUNT, AVG, MAX, MIN.
--    - Syntax:
--         SELECT column1, aggregate_function(column2)
--         FROM table_name
--         GROUP BY column1;
--    - Examples of aggregate functions:
--         SUM(column)   → total sum
--         COUNT(*)      → number of rows
--         AVG(column)   → average value
--         MAX(column)   → maximum value
--         MIN(column)   → minimum value

-- 2. HAVING Clause:
--    - Used to filter groups created by GROUP BY.
--    - Similar to WHERE, but WHERE cannot filter aggregates.
--    - Syntax:
--         SELECT column1, aggregate_function(column2)
--         FROM table_name
--         GROUP BY column1
--         HAVING aggregate_function(column2) condition;
--    - Example:
--         SELECT region, SUM(quantity) AS total_quantity
--         FROM sales
--         GROUP BY region
--         HAVING SUM(quantity) > 15;

-- 3. ORDER BY with GROUP BY:
--    - You can order the grouped results using ORDER BY.
--    - Syntax:
--         SELECT column1, aggregate_function(column2)
--         FROM table_name
--         GROUP BY column1
--         ORDER BY aggregate_function(column2) DESC;

-- 4. Key Points:
--    - GROUP BY groups rows by specified column(s).
--    - HAVING filters groups, while WHERE filters individual rows.
--    - Aggregate functions are usually used with GROUP BY to summarize data.
--    - Combining GROUP BY + ORDER BY is common to rank or sort results.

-- =====================================================================================
-- ================================= CODE ==============================================

-- Create sample table
CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    region VARCHAR(50),
    product VARCHAR(50),
    quantity INT,
    price DECIMAL(10,2),
    sale_date DATE
);

-- Insert sample data
INSERT INTO sales (sale_id, region, product, quantity, price, sale_date) VALUES
(1, 'North', 'Laptop', 5, 50000, '2023-01-10'),
(2, 'South', 'Mobile', 10, 15000, '2023-02-14'),
(3, 'East', 'Laptop', 2, 48000, '2023-03-05'),
(4, 'North', 'Tablet', 8, 20000, '2023-04-20'),
(5, 'West', 'Mobile', 7, 18000, '2023-04-25'),
(6, 'East', 'Tablet', 3, 22000, '2023-05-30'),
(7, 'South', 'Laptop', 4, 52000, '2023-06-10'),
(8, 'West', 'Laptop', 6, 55000, '2023-07-15'),
(9, 'North', 'Mobile', 9, 16000, '2023-08-12'),
(10, 'East', 'Mobile', 5, 15500, '2023-09-02');

-- ============================================
--  GROUP BY Examples
-- ============================================

-- 1. Total quantity sold by region
SELECT region, SUM(quantity) AS total_quantity
FROM sales
GROUP BY region;

-- 2. Total revenue (quantity * price) per region
SELECT region, SUM(quantity * price) AS total_revenue
FROM sales
GROUP BY region;

-- 3. Total quantity sold per product
SELECT product, SUM(quantity) AS total_sold
FROM sales
GROUP BY product;

-- 4. Count of sales per region
SELECT region, COUNT(*) AS total_sales
FROM sales
GROUP BY region;

-- 5. Average price per product
SELECT product, AVG(price) AS avg_price
FROM sales
GROUP BY product;

-- ============================================
--  HAVING Clause Examples
-- ============================================

-- 6. Show regions where total quantity sold > 15
SELECT region, SUM(quantity) AS total_quantity
FROM sales
GROUP BY region
HAVING SUM(quantity) > 15;

-- 7. Show products where average price > 20000
SELECT product, AVG(price) AS avg_price
FROM sales
GROUP BY product
HAVING AVG(price) > 20000;

-- 8. Show regions with more than 2 products sold
SELECT region, COUNT(DISTINCT product) AS product_count
FROM sales
GROUP BY region
HAVING COUNT(DISTINCT product) > 2;

-- ============================================
--  GROUP BY + ORDER BY
-- ============================================

-- 9. Order total revenue per region (descending)
SELECT region, SUM(quantity * price) AS total_revenue
FROM sales
GROUP BY region
ORDER BY total_revenue DESC;

-- ============================================
--  Challenge Queries
-- ============================================

--  Find top 2 regions with highest total revenue
SELECT TOP 2 region, SUM(quantity * price) AS total_revenue
FROM sales
GROUP BY region
ORDER BY total_revenue DESC;

--  Find product-wise total revenue and filter only those earning > ?3,00,000
SELECT product, SUM(quantity * price) AS total_revenue
FROM sales
GROUP BY product
HAVING SUM(quantity * price) > 300000;


