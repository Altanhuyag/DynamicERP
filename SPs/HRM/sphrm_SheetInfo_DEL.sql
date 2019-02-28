IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_SheetInfo_DEL')
DROP PROC sphrm_SheetInfo_DEL
GO
CREATE PROC sphrm_SheetInfo_DEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc				INT,			
			@SheetInfoPkID		nvarchar(16)
			
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH ( SheetInfoPkID		nvarchar(16))
	EXEC sp_xml_removedocument @idoc

	SELECT @SheetInfoPkID=SheetInfoPkID FROM #tmp
	
	DELETE FROM hrmSheetInfo 
	where SheetInfoPkID=@SheetInfoPkID
END
GO
