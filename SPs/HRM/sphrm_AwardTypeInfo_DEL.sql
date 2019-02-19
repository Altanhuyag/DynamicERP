IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_AwardTypeInfo_DEL')
DROP PROC sphrm_AwardTypeInfo_DEL
GO
CREATE PROC sphrm_AwardTypeInfo_DEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc			INT,
			@AwardTypeInfoPkID		nvarchar(16)
			
			
			
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (	AwardTypeInfoPkID		nvarchar(16))
	EXEC sp_xml_removedocument @idoc

	SELECT @AwardTypeInfoPkID=AwardTypeInfoPkID FROM #tmp
	
	DELETE FROM hrmAwardTypeInfo
	where AwardTypeInfoPkID = @AwardTypeInfoPkID
	
	END
GO
