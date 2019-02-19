IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_AdvertenceTypeInfo_DEL')
DROP PROC sphrm_AdvertenceTypeInfo_DEL
GO
CREATE PROC sphrm_AdvertenceTypeInfo_DEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc			INT,
			@AdvertenceTypeInfoPkID		nvarchar(16)
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (	AdvertenceTypeInfoPkID		nvarchar(16))
	EXEC sp_xml_removedocument @idoc

	SELECT @AdvertenceTypeInfoPkID=AdvertenceTypeInfoPkID FROM #tmp
	
	DELETE FROM hrmAdvertenceTypeInfo
	where AdvertenceTypeInfoPkID = @AdvertenceTypeInfoPkID
	
	END
GO
