IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_HolidayDay_GET')
DROP PROC sphrm_HolidayDay_GET
GO
CREATE PROC sphrm_HolidayDay_GET
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc				Int,
			@WorkedYear		int,
			@SortOrder			nvarchar(150)
			
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (  WorkedYear		int)

	EXEC sp_xml_removedocument @idoc 	

	
	SELECT	@WorkedYear=WorkedYear	FROM #tmp
	
	select * from hrmRestDayConfig where @WorkedYear between LowLevel and HighLevel

END
GO
