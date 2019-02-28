IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_Graduate_DEL')
DROP PROC sphrm_Graduate_DEL
GO
CREATE PROC sphrm_Graduate_DEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc				INT,			
			@GraduatePkID		nvarchar(16)
			
			
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (	GraduatePkID		nvarchar(16))
	EXEC sp_xml_removedocument @idoc

	SELECT @GraduatePkID=GraduatePkID FROM #tmp
	
	DELETE FROM hrmGraduate WHERE GraduatePkID=@GraduatePkID
END
GO
