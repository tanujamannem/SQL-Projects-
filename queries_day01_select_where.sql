-- =====================================================================================
-- Topic: SELECT and WHERE
-- Author: Tanuja Mannem
-- Description: Basic queries to fetch and filter data
-- =====================================================================================

-- ================================= THEORY ============================================
-- 1. SELECT Statement:
--    - Used to fetch data from a table.
--    - Can fetch all columns using '*' or specific columns.
--    - Syntax:
--         SELECT column1, column2, ...
--         FROM table_name;
--    - Example:
--         SELECT name, age FROM students;

-- 2. WHERE Clause:
--    - Used to filter records based on a condition.
--    - Only rows satisfying the condition are returned.
--    - Syntax:
--         SELECT column1, column2, ...
--         FROM table_name
--         WHERE condition;
--    - Common operators:
--         =   (equal to)
--         >   (greater than)
--         <   (less than)
--         >=  (greater than or equal to)
--         <=  (less than or equal to)
--         <>  or != (not equal to)
--         AND, OR, NOT (combine multiple conditions)
--    - Example:
--         SELECT * FROM students WHERE age > 20;

-- 3. Table Creation and Data Insertion:
--    - CREATE TABLE defines the structure of a table.
--    - INSERT INTO adds data to the table.
--    - DROP TABLE IF EXISTS removes the table if it already exists.
--    - Example:
--         DROP TABLE IF EXISTS students;
--         CREATE TABLE students (id INT PRIMARY KEY, name VARCHAR(50), age INT);
--         INSERT INTO students (id, name, age) VALUES (1, 'Anita', 22);

-- 4. Key Points:
--    - SELECT fetches data; WHERE filters data.
--    - Always define a primary key to uniquely identify rows.
--    - Combine multiple conditions with AND / OR:
--         SELECT * FROM students WHERE age > 20 AND city = 'Hyderabad';

-- =====================================================================================
-- ================================= CODE ==============================================
-- Drop and recreate table
DROP TABLE IF EXISTS students;
CREATE TABLE students (
  id INT PRIMARY KEY,
  name VARCHAR(50),
  age INT,
  city VARCHAR(50),
  marks INT
);

-- Insert some data
INSERT INTO students (id, name, age, city, marks)
VALUES
(1, 'Anita', 22, 'Hyderabad', 78),
(2, 'Ravi', 19, 'Chennai', 65),
(3, 'Kavya', 24, 'Mumbai', 82),
(4, 'Asha', 21, 'Hyderabad', 55),
(5, 'Vikram', 20, 'Delhi', 71);

-- View all students
SELECT * FROM students;

-- View students older than 20
SELECT * FROM students WHERE age > 20;

-- View students from Hyderabad
SELECT * FROM students WHERE city = 'Hyderabad';

