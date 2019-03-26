
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spint_docDocumentGET_SEL')
DROP PROC spint_docDocumentGET_SEL
GO
CREATE PROC spint_docDocumentGET_SEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 

BEGIN
	
	SET NOCOUNT ON
	DECLARE @idoc						Int,			
			@DocumentPkID				nvarchar(16),
			@EmployeeInfoPkID			nvarchar(16),
			@UserPkID					nvarchar(16)
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (  
				DocumentPkID		nvarchar(16),
				EmployeeInfoPkID	nvarchar(16),
				UserPkID			nvarchar(16)
			 )
	EXEC sp_xml_removedocument @idoc 	
	
	SELECT	@DocumentPkID = DocumentPkID, @EmployeeInfoPkID = EmployeeInfoPkID, @UserPkID = UserPkID
	FROM #tmp

	IF EXISTS (SELECT * FROM docDocumentEmployee WHERE DocumentPkID = @DocumentPkID AND EmployeeInfoPkID = @EmployeeInfoPkID)						--Not Permitted
	BEGIN
		SELECT DocumentPkID, DocumentDate, DocumentNo, a.CompanyName, Subject, 
		PageCnt, DocumentFilePath, a.CreatedDate, c.ValueStr1 AS StatusName, 
		(CASE WHEN IsReturn = N'Y' THEN N'Тийм' ELSE N'Үгүй' END) AS IsReturnName, ReturnDate, 
		d.DepartmentName, ReturnDescr, a.UserPkID, 'Y' as CanComment
		FROM docDocument a
		LEFT JOIN smmUserInfo b on b.UserPkID = a.UserPkID
		LEFT JOIN (SELECT ConstKey, ValueStr1 FROM smmConstants WHERE ConstType = N'docDocumentStatus') c on c.ConstKey = a.StatusID
		LEFT JOIN hrmDepartmentInfo d on d.DepartmentPkID = a.ReturnDepartmentPkID
		WHERE a.DocumentPkID = @DocumentPkID
	END
	ELSE IF EXISTS(SELECT * FROM smmUserInPermission WHERE MenuInfoId='0901' AND UserGroupID IN (SELECT TOP 1 UserGroupID FROM smmUserProgInfo WHERE UserPkID = @UserPkID AND ModuleID = 'INT')) --HRM Manager
	BEGIN
		SELECT DocumentPkID, DocumentDate, DocumentNo, a.CompanyName, Subject, 
		PageCnt, DocumentFilePath, a.CreatedDate, c.ValueStr1 AS StatusName, 
		(CASE WHEN IsReturn = N'Y' THEN N'Тийм' ELSE N'Үгүй' END) AS IsReturnName, ReturnDate, 
		d.DepartmentName, ReturnDescr, a.UserPkID, 'N' as CanComment
		FROM docDocument a
		LEFT JOIN smmUserInfo b on b.UserPkID = a.UserPkID
		LEFT JOIN (SELECT ConstKey, ValueStr1 FROM smmConstants WHERE ConstType = N'docDocumentStatus') c on c.ConstKey = a.StatusID
		LEFT JOIN hrmDepartmentInfo d on d.DepartmentPkID = a.ReturnDepartmentPkID
		WHERE a.DocumentPkID = @DocumentPkID
	END
	ELSE
	BEGIN
		SELECT 'Not found'
	END

END
GO
