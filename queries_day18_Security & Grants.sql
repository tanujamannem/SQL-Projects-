-- =============================================================
-- DAY 18 – SECURITY & GRANTS IN SQL
-- Author: Tanuja Mannem
-- Description:
--   Learn how to manage database security using users, roles,
--   permissions (GRANT, REVOKE, DENY), and best practices.
-- =============================================================

-- =============================================================
--  THEORY
-- =============================================================

--  Why Security Matters?
-- In SQL, security controls who can access the database and what actions they can perform.
-- Proper permission management prevents unauthorized access and data loss.

-- =============================================================
--  Authentication vs Authorization
-- =============================================================
--  Authentication Verifies *who* the user is (login credentials)
--  Authorization Decides *what* the user can do (permissions)

-- =============================================================
--  SQL Security Objects
-- =============================================================
-- 1. LOGIN : Created at the server level (connects to SQL Server)
-- 2. USER : Created at the database level (maps to a login)
-- 3. ROLE : A group of users with a defined set of permissions
-- 4. PERMISSIONS : Specific rights (e.g., SELECT, INSERT, UPDATE, DELETE)

-- =============================================================
--  Permission Commands
-- =============================================================
-- GRANT : Give permission
-- REVOKE : Remove previously granted permission
-- DENY : Explicitly block permission (even if granted via a role)

-- Syntax:
--   GRANT permission_type ON object_name TO user_name;
--   REVOKE permission_type ON object_name FROM user_name;
--   DENY permission_type ON object_name TO user_name;

-- =============================================================
--  CLEAN START
-- =============================================================
DROP TABLE IF EXISTS Employees;
GO

CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2)
);

INSERT INTO Employees VALUES
(101, 'Amit', 'HR', 55000),
(102, 'Bhavna', 'Finance', 62000),
(103, 'Chirag', 'IT', 70000);
GO

-- =============================================================
-- 1. CREATE USERS & ROLES (for demonstration)
-- =============================================================

--  Create two users
CREATE USER Analyst WITHOUT LOGIN;
CREATE USER Manager WITHOUT LOGIN;
GO

--  Create a custom database role
CREATE ROLE DataReaders;
GO

--  Add Analyst to DataReaders role
ALTER ROLE DataReaders ADD MEMBER Analyst;
GO

-- =============================================================
-- 2. GRANT PERMISSIONS
-- =============================================================

--  Allow Analysts to only read data
GRANT SELECT ON Employees TO DataReaders;
GO

--  Allow Manager full data modification access
GRANT SELECT, INSERT, UPDATE, DELETE ON Employees TO Manager;
GO

-- =============================================================
-- 3. REVOKE & DENY EXAMPLES
-- =============================================================

--  Revoke Analyst’s ability to SELECT (removes grant)
REVOKE SELECT ON Employees FROM DataReaders;
GO

--  Deny Analyst from deleting (even if role grants later)
DENY DELETE ON Employees TO Analyst;
GO

-- =============================================================
-- 4. VERIFY PERMISSIONS (Conceptual)
-- =============================================================
-- To check permissions, use:
--   SELECT * FROM fn_my_permissions('Employees', 'OBJECT');
--   EXECUTE AS USER = 'Analyst';   -- simulate user
--   SELECT * FROM Employees;       -- test access
--   REVERT;                        -- return to original user

-- =============================================================
-- 5. ROLE MANAGEMENT
-- =============================================================

--  View all roles
SELECT * FROM sys.database_principals WHERE type = 'R';

--  View members of a role
EXEC sp_helprolemember 'DataReaders';

--  Remove user from role
ALTER ROLE DataReaders DROP MEMBER Analyst;

--  Drop role and users
DROP ROLE IF EXISTS DataReaders;
DROP USER IF EXISTS Analyst;
DROP USER IF EXISTS Manager;
GO

-- =============================================================
--  CHALLENGE QUERIES
-- =============================================================

-- 1. Create a new role named "HR_Admin" and grant it INSERT & UPDATE permissions.
CREATE ROLE HR_Admin;
GRANT INSERT, UPDATE ON Employees TO HR_Admin;

-- 2. Create a new user "HR_User" and add to HR_Admin.
CREATE USER HR_User WITHOUT LOGIN;
ALTER ROLE HR_Admin ADD MEMBER HR_User;

-- 3. Try denying UPDATE to HR_User (overrides role permission).
DENY UPDATE ON Employees TO HR_User;

-- 4. Verify user and role assignments.
EXEC sp_helprolemember 'HR_Admin';

-- 5. Clean up after testing
DROP ROLE IF EXISTS HR_Admin;
DROP USER IF EXISTS HR_User;
GO

-- =============================================================
--  END OF DAY 18
-- Key Learnings:
-- - Understood SQL security model (login, user, role, permissions)
-- - Practiced GRANT, REVOKE, and DENY
-- - Learned how to control data access per role/user
-- - Explored real-world permission scenarios
-- =============================================================

