--another way to cerate the constraint or rule between two tables called as triggers

CREATE TABLE Employee
(
    EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    Department VARCHAR(50),
    Salary DECIMAL(10,2)
);

CREATE TABLE Employee_Audit
(
    AuditID INT IDENTITY(1,1) PRIMARY KEY,
    EmployeeID INT,
    ValidationStatus VARCHAR(20),
    ValidationMessage VARCHAR(500),
    AuditAction VARCHAR(20),
    AuditDate DATETIME DEFAULT GETDATE()
);

CREATE  TRIGGER trg_Employee_Audit
ON Employee
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Employee_Audit
    (
        EmployeeID,
        ValidationStatus,
        ValidationMessage,
        AuditAction
    )
    SELECT
        EmployeeID,

        CASE
            WHEN FirstName IS NULL OR LTRIM(RTRIM(FirstName)) = ''
                THEN 'FAILED'

            WHEN LastName IS NULL OR LTRIM(RTRIM(LastName)) = ''
                THEN 'FAILED'

            WHEN Email IS NULL OR LTRIM(RTRIM(Email)) = ''
                THEN 'FAILED'

            WHEN Email NOT LIKE '%_@_%._%'
                THEN 'FAILED'

            WHEN Department IS NULL OR LTRIM(RTRIM(Department)) = ''
                THEN 'FAILED'

            WHEN Salary IS NULL OR Salary <= 0
                THEN 'FAILED'

            ELSE 'PASSED'
        END AS ValidationStatus,

        CASE
            WHEN FirstName IS NULL OR LTRIM(RTRIM(FirstName)) = ''
                THEN 'FirstName is missing'

            WHEN LastName IS NULL OR LTRIM(RTRIM(LastName)) = ''
                THEN 'LastName is missing'

            WHEN Email IS NULL OR LTRIM(RTRIM(Email)) = ''
                THEN 'Email is missing'

            WHEN Email NOT LIKE '%_@_%._%'
                THEN 'Invalid email format'

            WHEN Department IS NULL OR LTRIM(RTRIM(Department)) = ''
                THEN 'Department is missing'

            WHEN Salary IS NULL OR Salary <= 0
                THEN 'Salary must be greater than zero'

            ELSE 'All validations passed'
        END AS ValidationMessage,

        'INSERT' AS AuditAction

    FROM inserted;
END;


INSERT INTO Employee
(
    FirstName,
    LastName,
    Email,
    Department,
    Salary
)
VALUES
(
    null,
    'Singh',
    'swetha@gmail.com',
    'IT',
    0
);

SELECT * FROM Employee;
SELECT * FROM Employee_Audit;


CREATE  TRIGGER trg_Employee_Validation
ON Employee
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;

    ------------------------------------------------
    -- 1. VALID RECORDS
    ------------------------------------------------
    INSERT INTO Employee
    (
        FirstName,
        LastName,
        Email,
        Department,
        Salary
    )
    SELECT
        FirstName,
        LastName,
        Email,
        Department,
        Salary
    FROM inserted
    WHERE
        FirstName IS NOT NULL
        AND LTRIM(RTRIM(FirstName)) <> ''

        AND LastName IS NOT NULL
        AND LTRIM(RTRIM(LastName)) <> ''

        AND Email IS NOT NULL
        AND LTRIM(RTRIM(Email)) <> ''

        AND Email LIKE '%_@_%._%'

        AND Department IS NOT NULL
        AND LTRIM(RTRIM(Department)) <> ''

        AND Salary IS NOT NULL
        AND Salary > 0;


    ------------------------------------------------
    -- 2. INVALID RECORDS → AUDIT TABLE
    ------------------------------------------------
    INSERT INTO Employee_Audit
    (
        EmployeeID,
        ValidationStatus,
        ValidationMessage,
        AuditAction
    )
    SELECT
        NULL,

        'FAILED',

        CASE
            WHEN FirstName IS NULL
                 OR LTRIM(RTRIM(FirstName)) = ''
                THEN 'FirstName is missing'

            WHEN LastName IS NULL
                 OR LTRIM(RTRIM(LastName)) = ''
                THEN 'LastName is missing'

            WHEN Email IS NULL
                 OR LTRIM(RTRIM(Email)) = ''
                THEN 'Email is missing'

            WHEN Email NOT LIKE '%_@_%._%'
                THEN 'Invalid email format'

            WHEN Department IS NULL
                 OR LTRIM(RTRIM(Department)) = ''
                THEN 'Department is missing'

            WHEN Salary IS NULL
                 OR Salary <= 0
                THEN 'Salary must be greater than zero'

            ELSE 'Unknown validation error'
        END,

        'REJECTED'

    FROM inserted
    WHERE
        FirstName IS NULL
        OR LTRIM(RTRIM(FirstName)) = ''

        OR LastName IS NULL
        OR LTRIM(RTRIM(LastName)) = ''

        OR Email IS NULL
        OR LTRIM(RTRIM(Email)) = ''

        OR Email NOT LIKE '%_@_%._%'

        OR Department IS NULL
        OR LTRIM(RTRIM(Department)) = ''

        OR Salary IS NULL
        OR Salary <= 0;

END;
GO

INSERT INTO Employee
(
    FirstName,
    LastName,
    Email,
    Department,
    Salary
)
VALUES
(
    'akhil',
    'Singh',
    'akhil@gmail.com',
    'IT',
    75000
);
select * from Employee
 select * from Employee_Audit
INSERT INTO Employee
(
    FirstName,
    LastName,
    Email,
    Department,
    Salary
)
VALUES
(
    'Amit',
    '',
    'amitgmail.com',
    'IT',
    -5000
);