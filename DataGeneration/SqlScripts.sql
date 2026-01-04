-- ==========================================
-- OLTP база: HR_Variant7
-- ==========================================

-- 1) Employee
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
    Status            VARCHAR(20)   NOT NULL,
    CONSTRAINT PK_Employee PRIMARY KEY (EmployeeID),
    CONSTRAINT UQ_Employee_EmployeeCode UNIQUE (EmployeeCode),
    CONSTRAINT CK_Employee_Gender CHECK (Gender IS NULL OR Gender IN ('M','F')),
    CONSTRAINT CK_Employee_Dates CHECK (TerminationDate IS NULL OR TerminationDate >= HireDate)
);

-- 2) Department
CREATE TABLE dbo.Department (
    DepartmentID        INT            NOT NULL,
    DepartmentName      NVARCHAR(100)   NOT NULL,
    ParentDepartmentID  INT            NULL,
    ManagerEmployeeID   INT            NULL,
    CONSTRAINT PK_Department PRIMARY KEY (DepartmentID),
    CONSTRAINT FK_Department_Parent
        FOREIGN KEY (ParentDepartmentID) REFERENCES dbo.Department(DepartmentID),
    CONSTRAINT FK_Department_Manager
        FOREIGN KEY (ManagerEmployeeID) REFERENCES dbo.Employee(EmployeeID)
);

-- 3) Position
CREATE TABLE dbo.Position (
    PositionID     INT            NOT NULL,
    PositionName   NVARCHAR(100)  NOT NULL,
    Grade          NVARCHAR(30)   NULL,
    BaseSalary     DECIMAL(12,2)  NOT NULL,
    IsActive       BIT            NOT NULL,
    CONSTRAINT PK_Position PRIMARY KEY (PositionID),
    CONSTRAINT CK_Position_BaseSalary CHECK (BaseSalary >= 0),
    CONSTRAINT CK_Position_IsActive CHECK (IsActive IN (0,1))
);

-- 4) VacationType
CREATE TABLE dbo.VacationType (
    VacationTypeID      INT           NOT NULL,
    TypeName            NVARCHAR(80)  NOT NULL,
    IsPaid              BIT           NOT NULL,
    DefaultDaysPerYear  INT           NULL,
    IsActive            BIT           NOT NULL,
    CONSTRAINT PK_VacationType PRIMARY KEY (VacationTypeID),
    CONSTRAINT CK_VacType_DefaultDays CHECK (DefaultDaysPerYear IS NULL OR DefaultDaysPerYear >= 0),
    CONSTRAINT CK_VacType_Flags CHECK (IsPaid IN (0,1) AND IsActive IN (0,1))
);

-- 5) Vacation
CREATE TABLE dbo.Vacation (
    VacationID      BIGINT        NOT NULL,
    EmployeeID      INT           NOT NULL,
    VacationTypeID  INT           NOT NULL,
    StartDate       DATE          NOT NULL,
    EndDate         DATE          NOT NULL,
    DaysCount       INT           NOT NULL,
    Status          VARCHAR(20)   NOT NULL,
    CreatedAt       DATETIME2(0)  NOT NULL,
    ApprovedAt      DATETIME2(0)  NULL,
    CONSTRAINT PK_Vacation PRIMARY KEY (VacationID),
    CONSTRAINT FK_Vacation_Employee
        FOREIGN KEY (EmployeeID) REFERENCES dbo.Employee(EmployeeID),
    CONSTRAINT FK_Vacation_VacationType
        FOREIGN KEY (VacationTypeID) REFERENCES dbo.VacationType(VacationTypeID),
    CONSTRAINT CK_Vacation_Dates CHECK (EndDate >= StartDate),
    CONSTRAINT CK_Vacation_DaysCount CHECK (DaysCount > 0),
    CONSTRAINT CK_Vacation_ApprovedAt CHECK (ApprovedAt IS NULL OR ApprovedAt >= CreatedAt)
);

-- 6) EmployeePositionHistory
CREATE TABLE dbo.EmployeePositionHistory (
    PositionHistoryID  BIGINT         NOT NULL,
    EmployeeID         INT            NOT NULL,
    DepartmentID       INT            NOT NULL,
    PositionID         INT            NOT NULL,
    StartDate          DATE           NOT NULL,
    EndDate            DATE           NULL,
    Salary             DECIMAL(12,2)  NOT NULL,
    ChangeReason       NVARCHAR(200)  NULL,
    CONSTRAINT PK_EmployeePositionHistory PRIMARY KEY (PositionHistoryID),
    CONSTRAINT FK_EPH_Employee
        FOREIGN KEY (EmployeeID) REFERENCES dbo.Employee(EmployeeID),
    CONSTRAINT FK_EPH_Department
        FOREIGN KEY (DepartmentID) REFERENCES dbo.Department(DepartmentID),
    CONSTRAINT FK_EPH_Position
        FOREIGN KEY (PositionID) REFERENCES dbo.Position(PositionID),
    CONSTRAINT CK_EPH_Dates CHECK (EndDate IS NULL OR EndDate >= StartDate),
    CONSTRAINT CK_EPH_Salary CHECK (Salary >= 0)
);

-- ==========================================
-- Індекси для продуктивності (рекомендовано)
-- ==========================================

CREATE NONCLUSTERED INDEX IX_Department_ParentDepartmentID
ON dbo.Department (ParentDepartmentID);

CREATE NONCLUSTERED INDEX IX_Department_ManagerEmployeeID
ON dbo.Department (ManagerEmployeeID);

CREATE NONCLUSTERED INDEX IX_Vacation_EmployeeID
ON dbo.Vacation (EmployeeID);

CREATE NONCLUSTERED INDEX IX_Vacation_VacationTypeID
ON dbo.Vacation (VacationTypeID);

CREATE NONCLUSTERED INDEX IX_Vacation_StartEndDate
ON dbo.Vacation (StartDate, EndDate);

CREATE NONCLUSTERED INDEX IX_EPH_EmployeeID
ON dbo.EmployeePositionHistory (EmployeeID);

CREATE NONCLUSTERED INDEX IX_EPH_DepartmentID
ON dbo.EmployeePositionHistory (DepartmentID);

CREATE NONCLUSTERED INDEX IX_EPH_PositionID
ON dbo.EmployeePositionHistory (PositionID);

CREATE NONCLUSTERED INDEX IX_EPH_StartEndDate
ON dbo.EmployeePositionHistory (StartDate, EndDate);
