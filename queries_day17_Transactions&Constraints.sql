-- =============================================================
-- ?? DAY 16 – TRANSACTIONS & CONSTRAINTS
-- Author: Tanuja Mannem
-- Description:
--   Learn how to manage transactions using COMMIT, ROLLBACK, and SAVEPOINT.
--   Understand and apply different SQL constraints for data integrity.
-- =============================================================

-- =============================================================
-- ?? THEORY
-- =============================================================

-- ?? What are Transactions?
-- A transaction is a sequence of SQL operations performed as a single logical unit of work.
-- It ensures that either all operations succeed (COMMIT) or none take effect (ROLLBACK).

-- ? ACID Properties:
--  A — Atomicity: All or nothing.
--  C — Consistency: Data must be in a valid state before and after transaction.
--  I — Isolation: Concurrent transactions don’t affect each other.
--  D — Durability: Once committed, changes persist even after a crash.

-- ?? Transaction Control Commands:
--  BEGIN TRAN / START TRANSACTION ? Starts a new transaction.
--  COMMIT ? Saves the changes permanently.
--  ROLLBACK ? Undoes changes since the last COMMIT.
--  SAVEPOINT ? Marks a point within a transaction to roll back to.

-- ?? Constraints ensure data validity and integrity:
--  - PRIMARY KEY ? Uniquely identifies each record.
--  - FOREIGN KEY ? Enforces relationship between two tables.
--  - UNIQUE ? Ensures all values in a column are different.
--  - NOT NULL ? Ensures a column cannot store NULL values.
--  - CHECK ? Ensures a condition is met before inserting/updating data.
--  - DEFAULT ? Assigns a default value when none is provided.

-- =============================================================
-- ?? CLEAN START
-- =============================================================

DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Customers;
GO

-- =============================================================
-- 1?? CREATE TABLES WITH CONSTRAINTS
-- =============================================================

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    City VARCHAR(50) DEFAULT 'Unknown'
);
GO

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE DEFAULT GETDATE(),
    Amount DECIMAL(10,2) CHECK (Amount > 0),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);
GO

-- =============================================================
-- 2?? INSERT SAMPLE DATA
-- =============================================================

INSERT INTO Customers VALUES
(1, 'Amit Sharma', 'amit@gmail.com', 'Delhi'),
(2, 'Bhavna Patel', 'bhavna@gmail.com', 'Mumbai'),
(3, 'Chirag Mehta', NULL, 'Pune');
GO

INSERT INTO Orders VALUES
(101, 1, '2024-03-10', 2500.00),
(102, 2, '2024-03-12', 4800.50),
(103, 1, '2024-03-15', 1500.75);
GO

-- =============================================================
-- 3?? TRANSACTIONS – COMMIT & ROLLBACK
-- =============================================================

BEGIN TRANSACTION;

-- Try inserting invalid order (Amount < 0 will fail CHECK constraint)
INSERT INTO Orders VALUES (104, 3, '2024-03-20', -500.00);

-- The above statement will throw an error and not commit changes.
ROLLBACK;  -- Undo if something goes wrong

-- Insert valid order and commit
BEGIN TRANSACTION;
INSERT INTO Orders VALUES (104, 3, '2024-03-21', 3600.00);
COMMIT;

SELECT * FROM Orders;
GO

-- =============================================================
-- 4?? SAVEPOINT USAGE
-- =============================================================

BEGIN TRANSACTION;
UPDATE Orders SET Amount = Amount + 200 WHERE CustomerID = 1;
SAVE TRANSACTION BeforeDelete;

DELETE FROM Orders WHERE CustomerID = 2;

-- Rollback to savepoint (undo delete but keep updates)
ROLLBACK TRANSACTION BeforeDelete;

COMMIT TRANSACTION;

SELECT * FROM Orders;
GO

-- =============================================================
-- 5?? CONSTRAINT EXAMPLES
-- =============================================================

-- ?? NOT NULL Violation
-- INSERT INTO Customers (CustomerID, CustomerName, Email, City)
-- VALUES (4, NULL, 'new@gmail.com', 'Goa');  -- ? Error: NOT NULL constraint

-- ?? CHECK Constraint Violation
-- INSERT INTO Orders VALUES (105, 1, '2024-03-25', -1000); -- ? Error

-- ?? DEFAULT value example
INSERT INTO Customers (CustomerID, CustomerName, Email)
VALUES (4, 'Esha Kapoor', 'esha@gmail.com');  -- City defaults to 'Unknown'

SELECT * FROM Customers;
GO

-- =============================================================
-- 6?? CHALLENGE QUERIES
-- =============================================================

-- 1?? Create a savepoint before deleting data, then rollback to it.
BEGIN TRANSACTION;
DELETE FROM Orders WHERE Amount < 2000;
SAVE TRANSACTION BeforeRollback;
ROLLBACK TRANSACTION BeforeRollback;
COMMIT;

-- 2?? Try violating UNIQUE constraint.
-- INSERT INTO Customers VALUES (5, 'Farhan', 'amit@gmail.com', 'Hyderabad'); -- ? Error: duplicate email

-- 3?? Add a new CHECK constraint on Orders to ensure Amount <= 10000.
ALTER TABLE Orders ADD CONSTRAINT chk_MaxAmount CHECK (Amount <= 10000);

-- 4?? Test CHECK constraint.
-- INSERT INTO Orders VALUES (106, 2, '2024-03-28', 15000); -- ? Error: violates constraint

-- 5?? Verify all valid records
SELECT * FROM Orders;
GO

-- =============================================================
-- ? END OF DAY 16
-- Key Learnings:
-- - Understood ACID properties & transaction control commands.
-- - Practiced COMMIT, ROLLBACK, and SAVEPOINT.
-- - Created and applied various SQL constraints.
-- - Learned to maintain data integrity and consistency.
-- =============================================================
