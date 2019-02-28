IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_EmployeeLetOut_GET')
DROP PROC sphrm_EmployeeLetOut_GET
GO
CREATE PROC sphrm_EmployeeLetOut_GET
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc				INT,			
			@EmployeeLetOutPkID		nvarchar(16)
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH ( EmployeeLetOutPkID		nvarchar(16) )
	EXEC sp_xml_removedocument @idoc
	SELECT @EmployeeLetOutPkID=EmployeeLetOutPkID FROM #tmp
	select 
	A.*,B.JobExitReasonName,D.FirstName+'.'+SUBSTRING(D.LastName,1,1) as FirstName,
	A.UserName as EmployeeName  from hrmEmployeeLetOut A
	inner join hrmJobExitReason B on A.JobExitReasonPkID=B.JobExitReasonPkID
	inner join hrmEmployeeInfo D on A.EmployeeInfoPkID=D.EmployeeInfoPkID	
	where A.EmployeeLetOutPkID=@EmployeeLetOutPkID
END
GO
