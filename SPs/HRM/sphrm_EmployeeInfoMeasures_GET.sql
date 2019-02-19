IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_EmployeeInfoMeasures_GET')
DROP PROC sphrm_EmployeeInfoMeasures_GET
GO
CREATE PROC sphrm_EmployeeInfoMeasures_GET
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc			INT,
			@EmployeeInfoMeasuresPkID		nvarchar(16)
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (	EmployeeInfoMeasuresPkID		nvarchar(16))
	EXEC sp_xml_removedocument @idoc

	SELECT @EmployeeInfoMeasuresPkID=EmployeeInfoMeasuresPkID FROM #tmp
	
	select 
	A.*,B.LastName,B.FirstName,A.UserName as EmployeeName,C.BreachName from hrmEmployeeInfoMeasures A 
	left join hrmEmployeeInfo As B on A.EmployeeInfoPkID = B.EmployeeInfoPkID 	
	left join hrmBreachInfo As C on A.BreachPkID = C.BreachPkID
	where A.EmployeeInfoMeasuresPkID = @EmployeeInfoMeasuresPkID
	END
GO
