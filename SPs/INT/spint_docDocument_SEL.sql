﻿
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spint_docDocument_SEL')
DROP PROC spint_docDocument_SEL
GO
CREATE PROC spint_docDocument_SEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 

BEGIN
	
	SET NOCOUNT ON
	DECLARE @idoc						Int,			
			@DocumentTypeID				nvarchar(16)
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (  
				DocumentTypeID	nvarchar(16)
			 )
	EXEC sp_xml_removedocument @idoc 	
	
	SELECT	@DocumentTypeID = DocumentTypeID
	FROM #tmp

	SELECT DocumentPkID, DocumentDate, DocumentNo, a.CompanyName, Subject, 
	PageCnt, DocumentFilePath, a.CreatedDate, a.StatusID, c.ValueStr1 AS StatusName, 
	IsReturn, (CASE WHEN IsReturn = N'Y' THEN N'Тийм' ELSE N'Үгүй' END) AS IsReturnName, ReturnDate, 
	a.ReturnDepartmentPkID, d.DepartmentName, ReturnDescr
	FROM docDocument a
	INNER JOIN smmUserInfo b on b.UserPkID = a.UserPkID
	INNER JOIN (SELECT ConstKey, ValueStr1 FROM smmConstants WHERE ConstType = N'docDocumentStatus') c on c.ConstKey = a.StatusID
	INNER JOIN hrmDepartmentInfo d on d.DepartmentPkID = a.ReturnDepartmentPkID
	WHERE a.DocumentTypeID = @DocumentTypeID

END
GO
