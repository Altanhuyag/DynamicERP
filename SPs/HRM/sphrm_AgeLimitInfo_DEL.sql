IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_AgeLimitInfo_DEL')
DROP PROC sphrm_AgeLimitInfo_DEL
GO
CREATE PROC sphrm_AgeLimitInfo_DEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc			INT,
			@AgeLimitInfoPkID		nvarchar(16)
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (	AgeLimitInfoPkID		nvarchar(16))
	EXEC sp_xml_removedocument @idoc

	SELECT @AgeLimitInfoPkID=AgeLimitInfoPkID FROM #tmp
	
	DELETE FROM hrmAgeLimitInfo
	where AgeLimitInfoPkID = @AgeLimitInfoPkID
	
	END
GO
