USE HR_Variant7;
GO

-- =========================================
-- TABLE: Employee
-- =========================================
CREATE TABLE dbo.Employee (
    EmployeeID        INT           NOT NULL,
    EmployeeCode      VARCHAR(20)   NOT NULL,
    LastName          NVARCHAR(50)  NOT NULL,
    FirstName         NVARCHAR(50)  NOT NULL,
    MiddleName        NVARCHAR(50)  NULL,
    BirthDate         DATE          NULL,
    Gender            CHAR(1)       NULL,
    HireDate          DATE          NOT NULL,
    TerminationDate   DATE          NULL,
    Email             VARCHAR(100)  NULL,
    Phone             VARCHAR(30)   NULL,
    Status            VARCHAR(20)   NOT NULL
);

-- =========================================
-- TABLE: Department
-- =========================================
CREATE TABLE dbo.Department (
    DepartmentID        INT            NOT NULL,
    DepartmentName      NVARCHAR(100)   NOT NULL,
    ParentDepartmentID  INT            NULL,
    ManagerEmployeeID   INT            NULL
);

-- =========================================
-- TABLE: Position
-- =========================================
CREATE TABLE dbo.Position (
    PositionID     INT            NOT NULL,
    PositionName   NVARCHAR(100)  NOT NULL,
    Grade          NVARCHAR(30)   NULL,
    BaseSalary     DECIMAL(12,2)  NOT NULL,
    IsActive       BIT            NOT NULL
);

-- =========================================
-- TABLE: VacationType
-- =========================================
CREATE TABLE dbo.VacationType (
    VacationTypeID      INT           NOT NULL,
    TypeName            NVARCHAR(80)  NOT NULL,
    IsPaid              BIT           NOT NULL,
    DefaultDaysPerYear  INT           NULL,
    IsActive            BIT           NOT NULL
);

-- =========================================
-- TABLE: Vacation
-- =========================================
CREATE TABLE dbo.Vacation (
    VacationID      BIGINT        NOT NULL,
    EmployeeID      INT           NOT NULL,
    VacationTypeID  INT           NOT NULL,
    StartDate       DATE          NOT NULL,
    EndDate         DATE          NOT NULL,
    DaysCount       INT           NOT NULL,
    Status          VARCHAR(20)   NOT NULL,
    CreatedAt       DATETIME2(0)  NOT NULL,
    ApprovedAt      DATETIME2(0)  NULL
);

-- =========================================
-- TABLE: EmployeePositionHistory
-- =========================================
CREATE TABLE dbo.EmployeePositionHistory (
    PositionHistoryID  BIGINT         NOT NULL,
    EmployeeID         INT            NOT NULL,
    DepartmentID       INT            NOT NULL,
    PositionID         INT            NOT NULL,
    StartDate          DATE           NOT NULL,
    EndDate            DATE           NULL,
    Salary             DECIMAL(12,2)  NOT NULL,
    ChangeReason       NVARCHAR(200)  NULL
);
