IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_SheetDetailInfo_GET')
DROP PROC sphrm_SheetDetailInfo_GET
GO

CREATE PROC sphrm_SheetDetailInfo_GET
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 

BEGIN
	SET NOCOUNT ON

	DECLARE @idoc				Int,
			@SheetInfoPkID			nvarchar(50)
--			
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (  SheetInfoPkID			nvarchar(50))

	EXEC sp_xml_removedocument @idoc 	

	
	SELECT	@SheetInfoPkID=SheetInfoPkID	FROM #tmp
	
	select * from hrmSheetDetailInfo
	where SheetInfoPkID=@SheetInfoPkID
END
GO
