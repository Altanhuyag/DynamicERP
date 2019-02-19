IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_Advertence_DEL')
DROP PROC sphrm_Advertence_DEL
GO
CREATE PROC sphrm_Advertence_DEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc			INT,
			@AdvertencePkID	nvarchar(16)
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (	AdvertencePkID		nvarchar(16))
	EXEC sp_xml_removedocument @idoc

	SELECT @AdvertencePkID=AdvertencePkID FROM #tmp
	
	DELETE FROM hrmAdvertence
	where AdvertencePkID = @AdvertencePkID
	
	END
GO
