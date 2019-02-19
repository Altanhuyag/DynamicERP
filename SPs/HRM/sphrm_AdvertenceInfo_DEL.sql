IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_AdvertenceInfo_DEL')
DROP PROC sphrm_AdvertenceInfo_DEL
GO
CREATE PROC sphrm_AdvertenceInfo_DEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc			INT,
			@AdvertenceInfoPkID	nvarchar(16)
		
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (	AdvertenceInfoPkID		nvarchar(16))
	EXEC sp_xml_removedocument @idoc
	SELECT @AdvertenceInfoPkID=AdvertenceInfoPkID FROM #tmp
	DELETE FROM hrmAdvertenceInfo
	where AdvertenceInfoPkID = @AdvertenceInfoPkID
	
	END
GO
