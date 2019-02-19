IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_LocationCodeInfo_DEL')
DROP PROC sphrm_LocationCodeInfo_DEL
GO
CREATE PROC sphrm_LocationCodeInfo_DEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc					INT,			
			@LocationCodePkID		nvarchar(16)
		
			
			
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH ( LocationCodePkID		nvarchar(16)
						 )
	EXEC sp_xml_removedocument @idoc

	SELECT @LocationCodePkID=LocationCodePkID FROM #tmp
	
	delete from hrmLocationDepartmentInfo where LocationCodePkID = @LocationCodePkID
	
	DELETE A
	FROM hrmLocationCodeInfo A
		INNER JOIN #tmp B ON A.LocationCodePkID=B.LocationCodePkID
		
	
END
GO
