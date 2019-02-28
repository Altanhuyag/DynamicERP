IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_OfficeToolsInfo_DEL')
DROP PROC sphrm_OfficeToolsInfo_DEL
GO
CREATE PROC sphrm_OfficeToolsInfo_DEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc			INT,
			@OfficeToolsInfoPkID		nvarchar(16)
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (	OfficeToolsInfoPkID		nvarchar(16))
	EXEC sp_xml_removedocument @idoc

	SELECT @OfficeToolsInfoPkID=OfficeToolsInfoPkID FROM #tmp
	
	DELETE FROM hrmOfficeToolsInfo
	where OfficeToolsInfoPkID = @OfficeToolsInfoPkID
	
	END
GO
