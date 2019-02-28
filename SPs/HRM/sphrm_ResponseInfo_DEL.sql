IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_ResponseInfo_DEL')
DROP PROC sphrm_ResponseInfo_DEL
GO
CREATE PROC sphrm_ResponseInfo_DEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc			INT,
			@ResponseInfoPkID		nvarchar(16)
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (	ResponseInfoPkID		nvarchar(16))
	EXEC sp_xml_removedocument @idoc

	SELECT @ResponseInfoPkID=ResponseInfoPkID FROM #tmp
	
	DELETE FROM hrmResponseInfo
	where ResponseInfoPkID = @ResponseInfoPkID
	
	END
GO
