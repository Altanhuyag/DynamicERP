IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_EventInfo_DEL')
DROP PROC sphrm_EventInfo_DEL
GO
CREATE PROC sphrm_EventInfo_DEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc			INT,
			@EventInfoPkID	nvarchar(16)
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (	EventInfoPkID		nvarchar(16))
	EXEC sp_xml_removedocument @idoc

	SELECT @EventInfoPkID=EventInfoPkID FROM #tmp
	
	DELETE FROM hrmEventInfo
	where EventInfoPkID = @EventInfoPkID
	
	END
GO
