IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_AwardInfo_DEL')
DROP PROC sphrm_AwardInfo_DEL
GO
CREATE PROC sphrm_AwardInfo_DEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc			INT,
			@AwardInfoPkID	nvarchar(16)
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (	AwardInfoPkID		nvarchar(16))
	EXEC sp_xml_removedocument @idoc

	SELECT @AwardInfoPkID=AwardInfoPkID FROM #tmp
	
	DELETE FROM hrmAwardInfo
	where AwardInfoPkID = @AwardInfoPkID
	
	END
GO
