-- =============================================================
--  DAY 14 – TRIGGERS IN SQL (FULL VERSION)
--  Author: Tanuja Mannem
--  Description:
--    Learn all about SQL Triggers:
--    - What are triggers & why they’re useful
--    - DML, DDL, and LOGON triggers
--    - BEFORE, AFTER, and INSTEAD OF triggers
--    - Practical examples: Audit, Validation, Restriction
-- =============================================================


-- =============================================================
--  THEORY
-- =============================================================

-- ?? What is a Trigger?
-- A TRIGGER is a special kind of stored procedure that automatically executes
-- (fires) in response to specific database events such as INSERT, UPDATE, DELETE,
-- or even schema changes and logons.

-- Triggers help:
-- ? Enforce business rules
-- ? Maintain audit trails
-- ? Prevent invalid transactions
-- ? Automate actions after data changes

-- =============================================================
--  TYPES OF TRIGGERS
-- =============================================================

-- 1?? DML TRIGGERS (Data Manipulation Language)
-- Triggered by data changes (INSERT, UPDATE, DELETE).
-- Can be AFTER, BEFORE, or INSTEAD OF the DML action.

-- 2?? DDL TRIGGERS (Data Definition Language)
-- Triggered by schema changes (CREATE, ALTER, DROP).

-- 3?? LOGON TRIGGERS
-- Fired when a user logs into the database (used for auditing or limiting connections).

-- =============================================================
--  TYPES BASED ON EXECUTION TIME
-- =============================================================

-- ?? BEFORE Trigger:
--     Executes before the DML statement.
--     Used to validate or modify data before insert/update.
--     (Supported in MySQL, not SQL Server)

-- ?? AFTER Trigger:
--     Executes after the DML statement.
--     Used for auditing, logging, cascading changes.

-- ?? INSTEAD OF Trigger:
--     Executes instead of the triggering statement.
--     Commonly used on views.


-- =============================================================
--  CLEAN START
-- =============================================================
DROP TABLE IF EXISTS EmployeeAudit;
DROP TABLE IF EXISTS Employees;
GO


-- =============================================================
-- 1. CREATE BASE TABLES
-- =============================================================
CREATE TABLE Employees (
    EmpID INT IDENTITY(1,1) PRIMARY KEY,
    EmpName VARCHAR(50),
    DeptName VARCHAR(50),
    Salary DECIMAL(10,2)
);
GO

CREATE TABLE EmployeeAudit (
    AuditID INT IDENTITY(1,1) PRIMARY KEY,
    EmpID INT,
    ActionType VARCHAR(20),
    ActionDate DATETIME DEFAULT GETDATE(),
    OldSalary DECIMAL(10,2),
    NewSalary DECIMAL(10,2),
    Remarks VARCHAR(100)
);
GO

INSERT INTO Employees (EmpName, DeptName, Salary) VALUES
('Amit', 'HR', 45000),
('Bhavna', 'Finance', 62000),
('Chirag', 'IT', 71000),
('Divya', 'IT', 82000),
('Esha', 'Marketing', 50000);
GO


-- =============================================================
-- 2. AFTER TRIGGERS (DML)
-- =============================================================

-- ?? Trigger: After UPDATE
CREATE TRIGGER trg_AfterUpdateSalary
ON Employees
AFTER UPDATE
AS
BEGIN
    INSERT INTO EmployeeAudit (EmpID, ActionType, OldSalary, NewSalary, Remarks)
    SELECT 
        i.EmpID,
        'SALARY UPDATED',
        d.Salary,
        i.Salary,
        CASE 
            WHEN i.Salary > d.Salary THEN 'Salary Increased'
            WHEN i.Salary < d.Salary THEN 'Salary Decreased'
            ELSE 'No Change'
        END
    FROM inserted i
    JOIN deleted d ON i.EmpID = d.EmpID;
END;
GO

-- TEST: Salary Update
UPDATE Employees SET Salary = Salary + 5000 WHERE DeptName = 'IT';
SELECT * FROM Employees;
SELECT * FROM EmployeeAudit;
GO


-- ?? Trigger: After DELETE
CREATE TRIGGER trg_AfterDeleteEmployee
ON Employees
AFTER DELETE
AS
BEGIN
    INSERT INTO EmployeeAudit (EmpID, ActionType, OldSalary, Remarks)
    SELECT EmpID, 'EMPLOYEE DELETED', Salary, 'Record removed from Employees table'
    FROM deleted;
END;
GO

-- TEST DELETE
DELETE FROM Employees WHERE EmpName = 'Esha';
SELECT * FROM Employees;
SELECT * FROM EmployeeAudit;
GO


-- ?? Trigger: After INSERT
CREATE TRIGGER trg_AfterInsertEmployee
ON Employees
AFTER INSERT
AS
BEGIN
    INSERT INTO EmployeeAudit (EmpID, ActionType, NewSalary, Remarks)
    SELECT EmpID, 'NEW EMPLOYEE ADDED', Salary, 'Inserted into Employees table'
    FROM inserted;
END;
GO

-- TEST INSERT
INSERT INTO Employees (EmpName, DeptName, Salary)
VALUES ('Farhan', 'Sales', 48000);
SELECT * FROM Employees;
SELECT * FROM EmployeeAudit;
GO


-- =============================================================
-- 3. INSTEAD OF TRIGGER (ON VIEW)
-- =============================================================
CREATE VIEW vw_EmployeeView AS
SELECT EmpID, EmpName, DeptName, Salary
FROM Employees;
GO

CREATE TRIGGER trg_InsteadOfInsert
ON vw_EmployeeView
INSTEAD OF INSERT
AS
BEGIN
    INSERT INTO Employees (EmpName, DeptName, Salary)
    SELECT EmpName, DeptName, Salary
    FROM inserted
    WHERE Salary >= 40000;  -- only allow salaries above 40k
END;
GO

-- TEST INSERT THROUGH VIEW
INSERT INTO vw_EmployeeView (EmpName, DeptName, Salary)
VALUES ('Gauri', 'Finance', 35000),  -- rejected
       ('Harsh', 'IT', 75000);       -- accepted

SELECT * FROM Employees;
GO


-- =============================================================
-- 4. DDL TRIGGER (on CREATE, DROP, ALTER)
-- =============================================================
CREATE TRIGGER trg_DDL_Activity
ON DATABASE
FOR CREATE_TABLE, DROP_TABLE, ALTER_TABLE
AS
BEGIN
    PRINT '?? Schema Change Detected!';
    PRINT 'DDL Operation was executed on this database.';
END;
GO

-- TEST (try creating a dummy table)
CREATE TABLE DummyTest (ID INT);
DROP TABLE DummyTest;
GO


-- =============================================================
-- 5. LOGON TRIGGER (for auditing connections)
-- =============================================================

-- ?? These triggers run when a user logs into SQL Server.
--    Typically used by DBAs for security and auditing.

-- NOTE: Run only if you have admin rights.

-- CREATE TRIGGER trg_Logon_Audit
-- ON ALL SERVER
-- FOR LOGON
-- AS
-- BEGIN
--     PRINT 'User login detected: auditing connection.';
-- END;
-- GO


-- =============================================================
-- 6. BEFORE TRIGGER (Example for MySQL users)
-- =============================================================
-- ?? SQL Server does NOT support BEFORE triggers.
-- Below example is valid for MySQL syntax only.

-- CREATE TRIGGER trg_BeforeInsert
-- BEFORE INSERT ON Employees
-- FOR EACH ROW
-- BEGIN
--     IF NEW.Salary < 30000 THEN
--         SIGNAL SQLSTATE '45000'
--         SET MESSAGE_TEXT = 'Salary too low to insert!';
--     END IF;
-- END;


-- =============================================================
-- 7. DISABLE, ENABLE, DROP TRIGGERS
-- =============================================================

-- Disable trigger
DISABLE TRIGGER trg_AfterUpdateSalary ON Employees;

-- Enable trigger
ENABLE TRIGGER trg_AfterUpdateSalary ON Employees;

-- Drop trigger (optional cleanup)
-- DROP TRIGGER trg_AfterUpdateSalary;
-- DROP TRIGGER trg_AfterDeleteEmployee;
-- DROP TRIGGER trg_AfterInsertEmployee;
-- DROP TRIGGER trg_InsteadOfInsert;
-- DROP TRIGGER trg_DDL_Activity;
GO


-- =============================================================
--  CHALLENGE QUERIES
-- =============================================================

-- 1?? Create a trigger that prevents deleting employees from the HR department.
-- 2?? Create a trigger that logs INSERT, UPDATE, and DELETE into one audit table.
-- 3?? Modify the salary update trigger to prevent salary > 1,00,000.
-- 4?? Create a DDL trigger that alerts whenever someone drops a table.


-- =============================================================
--  END OF DAY 14
--  KEY LEARNINGS:
--  ? Understood DML, DDL, and LOGON triggers
--  ? Practiced AFTER, BEFORE, and INSTEAD OF triggers
--  ? Used inserted/deleted pseudo-tables for tracking changes
--  ? Logged audit details for INSERT, UPDATE, DELETE
--  ? Prevented unwanted transactions and enforced rules
-- =============================================================
