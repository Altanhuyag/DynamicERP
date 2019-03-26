IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spint_docDocumentComment_UPD')
DROP PROC spint_docDocumentComment_UPD
GO
CREATE PROC spint_docDocumentComment_UPD
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
			@EmployeeInfoPkID	nvarchar(16),
			@Description		nvarchar(4000)
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (  
				DocumentPkID		nvarchar(16),
				EmployeeInfoPkID	nvarchar(16),
				Description			nvarchar(4000)
			 )
	EXEC sp_xml_removedocument @idoc 	
	
	SELECT	@DocumentPkID=DocumentPkID,			
			@EmployeeInfoPkID=EmployeeInfoPkID,
			@Description=Description
	FROM #tmp
   	
	INSERT INTO docDocumentComment VALUES(@DocumentPkID, @EmployeeInfoPkID, @Description, N'', GETDATE())
	SELECT @@IDENTITY as CommentPkID

END
GO