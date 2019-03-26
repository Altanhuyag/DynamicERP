
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spint_docDocument_DEL')
DROP PROC spint_docDocument_DEL
GO
CREATE PROC spint_docDocument_DEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 

BEGIN
	
	SET NOCOUNT ON
	DECLARE @idoc						Int,	
			@id							nvarchar(16)
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (  
				id							nvarchar(16)
			 )
	EXEC sp_xml_removedocument @idoc 	
	
	SELECT	
	@id = id
	FROM #tmp
	
	BEGIN TRANSACTION

	DELETE FROM docDocument WHERE DocumentPkID = @id

	DELETE FROM docDocumentEmployee WHERE DocumentPkID = @id

	COMMIT TRANSACTION

END
GO
