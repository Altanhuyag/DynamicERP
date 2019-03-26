IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spint_docDocumentCommentImage_UPD')
DROP PROC spint_docDocumentCommentImage_UPD
GO
CREATE PROC spint_docDocumentCommentImage_UPD
(
			@XML		  NVARCHAR(MAX),
			@IntResult    TINYINT		 OUTPUT,
			@StrResult    NVARCHAR(2000) OUTPUT	
) WITH ENCRYPTION
AS

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc				Int,			
			@CommentPkID		int,
			@ImageFileExt		nvarchar(10)
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (  
				CommentPkID		nvarchar(16),
				ImageFileExt		nvarchar(10)
			 )
	EXEC sp_xml_removedocument @idoc 	
	
	SELECT	@CommentPkID=CommentPkID,			
			@ImageFileExt=ImageFileExt
	FROM #tmp
   	
	UPDATE docDocumentComment
	SET CommentFilePath = N'/upload/document/comment/'+ CONVERT(nvarchar, @CommentPkID) + @ImageFileExt
	WHERE CommentPkID = @CommentPkID

END
GO