
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spint_docDepartmentEmployee_UPD')
DROP PROC spint_docDepartmentEmployee_UPD
GO
CREATE PROC spint_docDepartmentEmployee_UPD
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 

BEGIN
	
	SET NOCOUNT ON
	DECLARE @idoc						Int,	
			@id							nvarchar(16),
			@Departments				nvarchar(max),
			@Employees					nvarchar(max),
			@ReturnDate					datetime,
			@ReturnDesc					nvarchar(1000)
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (  
				id						nvarchar(16),
				Departments				nvarchar(max),
				Employees				nvarchar(max),
				ReturnDate				datetime,
				ReturnDesc				nvarchar(1000)
			 )
	EXEC sp_xml_removedocument @idoc 	
	
	SELECT	
	@id = id,
	@Departments = Departments,
	@Employees = Employees,
	@ReturnDate = ReturnDate,
	@ReturnDesc = ReturnDesc
	FROM #tmp
	
	BEGIN TRANSACTION
	
	UPDATE docDocument 
	SET 
	IsReturn = 'Y',
	ReturnDate = @ReturnDate, 
	ReturnDescr = @ReturnDesc 
	WHERE 
	DocumentPkID = @id

	IF(@Departments <> '')
	BEGIN
		SET @Departments = SUBSTRING(@Departments, 2, len(@Departments)-2)

		DELETE FROM docDocumentEmployee WHERE DocumentPkID = @id 
		AND DepartmentPkID NOT IN (SELECT Name FROM splitstringbyseparator(@Departments, ','))

		DECLARE @depid VARCHAR(16)

		DECLARE dep_cur CURSOR FOR 
		SELECT Name FROM splitstringbyseparator(@Departments, ',')
		
		OPEN dep_cur  
		FETCH NEXT FROM dep_cur INTO @depid  

		WHILE @@FETCH_STATUS = 0  
		BEGIN  
				IF ((SELECT COUNT(*) FROM docDocumentEmployee WHERE DocumentPkID = @id AND DepartmentPkID = @depid) = 0)
				BEGIN
					INSERT INTO docDocumentEmployee VALUES (@id, @depid , N'', GETDATE())
				END

				FETCH NEXT FROM dep_cur INTO @depid 
		END 

		CLOSE dep_cur  
		DEALLOCATE dep_cur 
	END
	ELSE IF (@Employees <> '')
	BEGIN
		SET @Employees = SUBSTRING(@Employees, 2, len(@Employees)-2)

		DELETE FROM docDocumentEmployee WHERE DocumentPkID = @id 
		AND EmployeeInfoPkID NOT IN (SELECT Name FROM splitstringbyseparator(@Employees, ','))

		DECLARE @empid VARCHAR(16)

		DECLARE emp_cur CURSOR FOR 
		SELECT Name FROM splitstringbyseparator(@Employees, ',')
		
		OPEN emp_cur  
		FETCH NEXT FROM emp_cur INTO @empid

		WHILE @@FETCH_STATUS = 0  
		BEGIN  
				IF ((SELECT COUNT(*) FROM docDocumentEmployee WHERE DocumentPkID = @id AND EmployeeInfoPkID = @empid) = 0)
				BEGIN
					INSERT INTO docDocumentEmployee VALUES(@id, N'', @empid, GETDATE())
				END

				FETCH NEXT FROM emp_cur INTO @empid
		END 

		CLOSE emp_cur  
		DEALLOCATE emp_cur 
	END

	COMMIT TRANSACTION

END
GO
