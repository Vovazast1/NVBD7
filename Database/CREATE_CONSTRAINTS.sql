USE HR_Variant7;
GO

-- ========================
-- PRIMARY KEYS
-- ========================
ALTER TABLE dbo.Employee
ADD CONSTRAINT PK_Employee PRIMARY KEY (EmployeeID);

ALTER TABLE dbo.Department
ADD CONSTRAINT PK_Department PRIMARY KEY (DepartmentID);

ALTER TABLE dbo.Position
ADD CONSTRAINT PK_Position PRIMARY KEY (PositionID);

ALTER TABLE dbo.VacationType
ADD CONSTRAINT PK_VacationType PRIMARY KEY (VacationTypeID);

ALTER TABLE dbo.Vacation
ADD CONSTRAINT PK_Vacation PRIMARY KEY (VacationID);

ALTER TABLE dbo.EmployeePositionHistory
ADD CONSTRAINT PK_EmployeePositionHistory PRIMARY KEY (PositionHistoryID);

-- ========================
-- FOREIGN KEYS
-- ========================
ALTER TABLE dbo.Department
ADD CONSTRAINT FK_Department_Parent
FOREIGN KEY (ParentDepartmentID) REFERENCES dbo.Department(DepartmentID);

ALTER TABLE dbo.Department
ADD CONSTRAINT FK_Department_Manager
FOREIGN KEY (ManagerEmployeeID) REFERENCES dbo.Employee(EmployeeID);

ALTER TABLE dbo.Vacation
ADD CONSTRAINT FK_Vacation_Employee
FOREIGN KEY (EmployeeID) REFERENCES dbo.Employee(EmployeeID);

ALTER TABLE dbo.Vacation
ADD CONSTRAINT FK_Vacation_VacationType
FOREIGN KEY (VacationTypeID) REFERENCES dbo.VacationType(VacationTypeID);

ALTER TABLE dbo.EmployeePositionHistory
ADD CONSTRAINT FK_EPH_Employee
FOREIGN KEY (EmployeeID) REFERENCES dbo.Employee(EmployeeID);

ALTER TABLE dbo.EmployeePositionHistory
ADD CONSTRAINT FK_EPH_Department
FOREIGN KEY (DepartmentID) REFERENCES dbo.Department(DepartmentID);

ALTER TABLE dbo.EmployeePositionHistory
ADD CONSTRAINT FK_EPH_Position
FOREIGN KEY (PositionID) REFERENCES dbo.Position(PositionID);

-- ========================
-- CHECK CONSTRAINTS
-- ========================
ALTER TABLE dbo.Employee
ADD CONSTRAINT CK_Employee_Gender
CHECK (Gender IS NULL OR Gender IN ('M','F'));

ALTER TABLE dbo.Employee
ADD CONSTRAINT CK_Employee_Dates
CHECK (TerminationDate IS NULL OR TerminationDate >= HireDate);

ALTER TABLE dbo.Position
ADD CONSTRAINT CK_Position_BaseSalary
CHECK (BaseSalary >= 0);

ALTER TABLE dbo.Vacation
ADD CONSTRAINT CK_Vacation_Dates
CHECK (EndDate >= StartDate);

ALTER TABLE dbo.Vacation
ADD CONSTRAINT CK_Vacation_Days
CHECK (DaysCount > 0);

ALTER TABLE dbo.EmployeePositionHistory
ADD CONSTRAINT CK_EPH_Dates
CHECK (EndDate IS NULL OR EndDate >= StartDate);

ALTER TABLE dbo.EmployeePositionHistory
ADD CONSTRAINT CK_EPH_Salary
CHECK (Salary >= 0);
