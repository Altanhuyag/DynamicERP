IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_EmployeeLetOut_SEL')
DROP PROC sphrm_EmployeeLetOut_SEL
GO
CREATE PROC sphrm_EmployeeLetOut_SEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 

BEGIN
	select 
	A.*,B.JobExitReasonName,C.PositionName,D.FirstName+'.'+SUBSTRING(D.LastName,1,1) as FirstName,
	A.UserName as EmployeeName,D.RegisterNo  from hrmEmployeeLetOut A
	inner join hrmJobExitReason B on A.JobExitReasonPkID=B.JobExitReasonPkID
	inner join hrmEmployeeInfo D on A.EmployeeInfoPkID=D.EmployeeInfoPkID	
	left join hrmPositionInfo C on D.PositionPkID=C.PositionPkID
	
 
END
GO
