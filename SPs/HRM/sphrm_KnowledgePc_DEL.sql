IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_KnowledgePc_DEL')
DROP PROC sphrm_KnowledgePc_DEL
GO
CREATE PROC sphrm_KnowledgePc_DEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc			INT,
			@KnowledgePkID	nvarchar(16)
			
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (	KnowledgePkID		nvarchar(16))
	EXEC sp_xml_removedocument @idoc

	SELECT	@KnowledgePkID=KnowledgePkID FROM #tmp	
  
	DELETE FROM hrmKnowledgePc Where KnowledgePkID = @KnowledgePkID

	DELETE FROM hrmKnowledgePCProgram Where KnowledgePkID = @KnowledgePkID
END
GO
