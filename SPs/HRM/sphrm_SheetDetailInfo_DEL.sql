IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_SheetDetailInfo_DEL')
DROP PROC sphrm_SheetDetailInfo_DEL
GO
CREATE PROC sphrm_SheetDetailInfo_DEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc				INT,			
			@SheetDetailInfoPkID		nvarchar(16)
			
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH ( SheetDetailInfoPkID		nvarchar(16))
	EXEC sp_xml_removedocument @idoc

	SELECT @SheetDetailInfoPkID=SheetDetailInfoPkID FROM #tmp
	
	DELETE FROM hrmSheetDetailInfo 
	where SheetDetailInfoPkID=@SheetDetailInfoPkID
END
GO
