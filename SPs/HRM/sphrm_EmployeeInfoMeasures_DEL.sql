IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_EmployeeInfoMeasures_DEL')
DROP PROC sphrm_EmployeeInfoMeasures_DEL
GO
CREATE PROC sphrm_EmployeeInfoMeasures_DEL
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
	
	DELETE FROM hrmEmployeeInfoMeasures
	where EmployeeInfoMeasuresPkID = @EmployeeInfoMeasuresPkID
	
	END
GO
