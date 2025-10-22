-- queries_day01_select_where.sql
-- Topic: SELECT and WHERE
-- Author: Tanuja Mannem
-- Description: Basic queries to fetch and filter data

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
