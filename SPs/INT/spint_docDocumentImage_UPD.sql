IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spint_docDocumentImage_UPD')
DROP PROC spint_docDocumentImage_UPD
GO
CREATE PROC spint_docDocumentImage_UPD
(
			@XML		  NVARCHAR(MAX),
			@IntResult    TINYINT		 OUTPUT,
			@StrResult    NVARCHAR(2000) OUTPUT	
) WITH ENCRYPTION
AS

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc				Int,			
			@DocumentPkID		nvarchar(16),
			@ImageFileExt		nvarchar(10)
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (  
				DocumentPkID		nvarchar(16),
				ImageFileExt		nvarchar(10)
			 )
	EXEC sp_xml_removedocument @idoc 	
	
	SELECT	@DocumentPkID=DocumentPkID,			
			@ImageFileExt=ImageFileExt
	FROM #tmp
   	
	UPDATE docDocument
	SET DocumentFilePath = N'/upload/document/'+@DocumentPkID + @ImageFileExt
	WHERE DocumentPkID = @DocumentPkID

END
GO