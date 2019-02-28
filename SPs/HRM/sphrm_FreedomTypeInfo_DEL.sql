IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_FreedomTypeInfo_DEL')
DROP PROC sphrm_FreedomTypeInfo_DEL
GO
CREATE PROC sphrm_FreedomTypeInfo_DEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc			INT,
			@FreedomTypePkID		nvarchar(16)
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (	FreedomTypePkID		nvarchar(16))
	EXEC sp_xml_removedocument @idoc

	SELECT @FreedomTypePkID=FreedomTypePkID FROM #tmp
	
	DELETE FROM hrmFreedomTypeInfo
	where FreedomTypePkID = @FreedomTypePkID
	
	END
GO
