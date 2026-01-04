USE HR_Variant7;
GO

-- =========================================
-- Trigger: Automatically calculate DaysCount
-- =========================================
CREATE TRIGGER trg_Vacation_CalcDays
ON dbo.Vacation
AFTER INSERT, UPDATE
AS
BEGIN
    UPDATE v
    SET DaysCount = DATEDIFF(DAY, v.StartDate, v.EndDate) + 1
    FROM dbo.Vacation v
    JOIN inserted i ON v.VacationID = i.VacationID;
END;
GO
