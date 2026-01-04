USE HR_Variant7;
GO

-- =========================================
-- Procedure: Get employee vacation summary
-- =========================================
CREATE PROCEDURE dbo.sp_GetEmployeeVacationSummary
    @EmployeeID INT
AS
BEGIN
    SELECT 
        e.EmployeeID,
        e.LastName,
        e.FirstName,
        COUNT(v.VacationID) AS VacationCount,
        SUM(v.DaysCount) AS TotalVacationDays
    FROM dbo.Employee e
    LEFT JOIN dbo.Vacation v ON e.EmployeeID = v.EmployeeID
    WHERE e.EmployeeID = @EmployeeID
    GROUP BY e.EmployeeID, e.LastName, e.FirstName;
END;
GO
