IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_EmployeeInfoMeasures_SEL')
DROP PROC sphrm_EmployeeInfoMeasures_SEL
GO
CREATE PROC sphrm_EmployeeInfoMeasures_SEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 

BEGIN
	SET NOCOUNT ON
	
	select 
	A.*,B.LastName,B.FirstName AS FirstName,A.UserName as EmployeeName,D.BreachName,E.PositionName from hrmEmployeeInfoMeasures A 
	left join hrmEmployeeInfo As B on A.EmployeeInfoPkID = B.EmployeeInfoPkID	
	left join hrmBreachInfo As D on A.BreachPkID=D.BreachPkID
	left join hrmPositionInfo As E on B.PositionPkID=E.PositionPkID	
END
GO
