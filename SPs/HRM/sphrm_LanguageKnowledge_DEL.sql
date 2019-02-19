IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_LanguageKnowledge_DEL')
DROP PROC sphrm_LanguageKnowledge_DEL
GO
CREATE PROC sphrm_LanguageKnowledge_DEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc				INT,
			@LanguageKnowledgePkID		nvarchar(16)			
			
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (	LanguageKnowledgePkID		nvarchar(16))
	EXEC sp_xml_removedocument @idoc

	SELECT @LanguageKnowledgePkID=LanguageKnowledgePkID FROM #tmp
	
	DELETE FROM hrmLanguageKnowledge where LanguageKnowledgePkID=@LanguageKnowledgePkID
END
GO
