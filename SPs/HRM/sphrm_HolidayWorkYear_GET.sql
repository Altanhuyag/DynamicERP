IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_HolidayWorkYear_GET')
DROP PROC sphrm_HolidayWorkYear_GET
GO
CREATE PROC sphrm_HolidayWorkYear_GET
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc				Int,
			@EmployeeInfoPkID		nvarchar(250),
			@SortOrder			nvarchar(150)
			
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (  EmployeeInfoPkID		nvarchar(250))

	EXEC sp_xml_removedocument @idoc 	

	
	SELECT	@EmployeeInfoPkID=EmployeeInfoPkID	FROM #tmp
	
	select WorkedYear + (Year(getdate()) - Year(ActualEnterJobDate)) as Works,Year(getdate()) - Year(Birthday) as Age from hrmEmployeeInfo 
	where EmployeeInfoPkID = @EmployeeInfoPkID	

END
GO
