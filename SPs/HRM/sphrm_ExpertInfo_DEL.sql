IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_ExpertInfo_DEL')
DROP PROC sphrm_ExpertInfo_DEL
GO
CREATE PROC sphrm_ExpertInfo_DEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc			INT,
			@ExpertInfoPkID		nvarchar(16)
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (	ExpertInfoPkID		nvarchar(16))
	EXEC sp_xml_removedocument @idoc

	SELECT @ExpertInfoPkID=ExpertInfoPkID FROM #tmp
	
	DELETE FROM hrmExpertInfo
	where ExpertInfoPkID = @ExpertInfoPkID
	
	END
GO
