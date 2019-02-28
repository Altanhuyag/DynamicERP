IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_EmployeeImage_GET')
DROP PROC sphrm_EmployeeImage_GET
GO

CREATE PROC sphrm_EmployeeImage_GET
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 
BEGIN

	SET NOCOUNT ON
	DECLARE @idoc			INT,
			@EmployeeInfoPkID 	nvarchar(16)
	
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (  EmployeeInfoPkID		nvarchar(50))
	
	EXEC sp_xml_removedocument @idoc
	
	SELECT @EmployeeInfoPkID=EmployeeInfoPkID FROM #tmp 
	
	SELECT * FROM hrmEmployeeImage WHERE EmployeePkID=@EmployeeInfoPkID
	
END
GO
