IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_LocationCodeInfo_Department_GET')
DROP PROC sphrm_LocationCodeInfo_Department_GET
GO
CREATE PROC sphrm_LocationCodeInfo_Department_GET
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc					INT,			
			@DepartmentPkID		nvarchar(16)
		
			
			
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH ( DepartmentPkID		nvarchar(16)
						 )
	EXEC sp_xml_removedocument @idoc

	SELECT @DepartmentPkID=DepartmentPkID FROM #tmp
	
	select * from hrmLocationCodeInfo A
	left join hrmLocationDepartmentInfo B on A.LocationCodePkID = B.LocationCodePkID
	--where B.DepartmentPkID = @DepartmentPkID
	
END
GO
