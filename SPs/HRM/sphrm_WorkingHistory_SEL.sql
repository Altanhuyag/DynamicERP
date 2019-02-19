IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_WorkingHistory_SEL')
DROP PROC sphrm_WorkingHistory_SEL
GO
CREATE PROC sphrm_WorkingHistory_SEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 

BEGIN
	SET NOCOUNT ON
		
	SELECT a.*, b.EventInfoName, c.JobExitReasonName, d.RegisterNo, d.FirstName, case when a.isCompany = 'Y' then N'Тийм' else N'Үгүй' end as IsCompanyName FROM hrmWorkingHistory a
		join hrmJobExitReason c on c.JobExitReasonPkID=a.JobExitReasonPkID
		join hrmEmployeeInfo d on a.EmployeeInfoPkID=d.EmployeeInfoPkID
		join hrmEventInfo b on b.EventInfoPkID=a.EventInfoPkID
END
GO
