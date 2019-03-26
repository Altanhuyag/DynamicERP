
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spint_docDocumentCommentGET_SEL')
DROP PROC spint_docDocumentCommentGET_SEL
GO
CREATE PROC spint_docDocumentCommentGET_SEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 

BEGIN
	
	SET NOCOUNT ON
	DECLARE @idoc						Int,			
			@DocumentPkID				nvarchar(16)
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (  
				DocumentPkID		nvarchar(16)
			 )
	EXEC sp_xml_removedocument @idoc 	
	
	SELECT	@DocumentPkID = DocumentPkID
	FROM #tmp

	SELECT a.*, (SUBSTRING(b.LastName,1,1) + '.' + b.FirstName) as FullName FROM docDocumentComment a
	INNER JOIN hrmEmployeeInfo b on b.EmployeeInfoPkID = a.EmployeeInfoPkID 
	WHERE a.DocumentPkID = @DocumentPkID
	ORDER BY CommentDate DESC

END
GO
