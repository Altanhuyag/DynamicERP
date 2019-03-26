
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spint_docDocumentDep_SEL')
DROP PROC spint_docDocumentDep_SEL
GO
CREATE PROC spint_docDocumentDep_SEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 

BEGIN
	
	SET NOCOUNT ON
	DECLARE @idoc						Int,			
			@UserPkID					nvarchar(16)
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (  
				UserPkID	nvarchar(16)
			 )
	EXEC sp_xml_removedocument @idoc 	
	
	SELECT	@UserPkID = UserPkID
	FROM #tmp
	
	IF NOT EXISTS (
	SELECT b.PositionName, c.FirstName, c.LastName, d.UserPkID, a.* FROM hrmDepartmentInfo a
	LEFT JOIN hrmPositionInfo b on b.PositionPkID = a.ControlPositionPkID
	LEFT JOIN hrmEmployeeInfo c on c.PositionPkID = b.PositionPkID
	LEFT JOIN smmUserInfo d on d.EmployeeInfoPkID = c.EmployeeInfoPkID
	WHERE d.UserPkID = @UserPkID)
	BEGIN
		SELECT 'Not found'
	END
	ELSE
	BEGIN
		DECLARE @depid NVARCHAR(16)
		SELECT TOP 1 @depid = a.DepartmentPkID FROM hrmDepartmentInfo a
		LEFT JOIN hrmPositionInfo b on b.PositionPkID = a.ControlPositionPkID
		LEFT JOIN hrmEmployeeInfo c on c.PositionPkID = b.PositionPkID
		LEFT JOIN smmUserInfo d on d.EmployeeInfoPkID = c.EmployeeInfoPkID
		WHERE d.UserPkID = @UserPkID

		IF @depid IS NOT NULL
		BEGIN
			SELECT DocumentPkID, DocumentDate, DocumentNo, a.CompanyName, Subject, 
			PageCnt, DocumentFilePath, a.CreatedDate, c.ValueStr1 AS StatusName, 
			(CASE WHEN IsReturn = N'Y' THEN N'Тийм' ELSE N'Үгүй' END) AS IsReturnName, ReturnDate, 
			d.DepartmentName, ReturnDescr, (CASE WHEN DocumentTypeID = N'1' THEN N'Ирсэн' ELSE N'Явсан' END) AS DocTypeName
			FROM docDocument a
			LEFT JOIN (SELECT ConstKey, ValueStr1 FROM smmConstants WHERE ConstType = N'docDocumentStatus') c on c.ConstKey = a.StatusID
			LEFT JOIN hrmDepartmentInfo d on d.DepartmentPkID = a.ReturnDepartmentPkID
			WHERE 
			a.DocumentPkID IN (SELECT DocumentPkID FROM docDocumentEmployee WHERE DepartmentPkID = @depid)
			OR
			a.DocumentPkID IN (SELECT a.DocumentPkID FROM docDocumentEmployee a 
			INNER JOIN hrmEmployeeInfo b ON b.EmployeeInfoPkID = a.EmployeeInfoPkID
			WHERE b.DepartmentPkID = @depid)
			OR
			a.ReturnDepartmentPkID = @depid
		END
		ELSE
		BEGIN
			SELECT 'Not found'
		END
	END

END
GO
