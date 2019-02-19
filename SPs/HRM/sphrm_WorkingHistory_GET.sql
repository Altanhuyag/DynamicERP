IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_WorkingHistory_GET')
DROP PROC sphrm_WorkingHistory_GET
GO
CREATE PROC sphrm_WorkingHistory_GET
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc				INT,
			@WorkingHistoryPkID	nvarchar(16)
	
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (	WorkingHistoryPkID	nvarchar(16))
	
	EXEC sp_xml_removedocument @idoc

	SELECT @WorkingHistoryPkID=WorkingHistoryPkID FROM #tmp
	
	SELECT a.*, b.EventInfoName, c.JobExitReasonName, d.RegisterNo, d.FirstName, case when a.isCompany = 'Y' then N'Тийм' else N'Үгүй' end as IsCompanyName FROM hrmWorkingHistory a
		join hrmJobExitReason c on c.JobExitReasonPkID=a.JobExitReasonPkID
		join hrmEmployeeInfo d on a.EmployeeInfoPkID=d.EmployeeInfoPkID
		join hrmEventInfo b on b.EventInfoPkID=a.EventInfoPkID
	WHERE a.WorkingHistoryPkID = @WorkingHistoryPkID

END
GO
