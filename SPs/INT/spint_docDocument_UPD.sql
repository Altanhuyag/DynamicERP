
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spint_docDocument_UPD')
DROP PROC spint_docDocument_UPD
GO
CREATE PROC spint_docDocument_UPD
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 

BEGIN
	
	SET NOCOUNT ON
	DECLARE @idoc						Int,	
			@type						int,
			@id							nvarchar(16),
			@DocumentDate				nvarchar(16),
			@DocumentNo					nvarchar(16),
			@CompanyName				nvarchar(255),
			@Subject					nvarchar(1000),
			@PageCnt					int,
			@UserPkID					nvarchar(16),
			@StatusID					nvarchar(16),
			@IsReturn					nvarchar(1),
			@ReturnDate					datetime,
			@ReturnDepartments			nvarchar(max),
			@ReturnEmployees			nvarchar(max),
			@ReturnDescr				nvarchar(1000),
			@DocumentTypeID				nvarchar(16),
			@IsAll						nvarchar(1),
			@IsEmp						nvarchar(1)
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (  
				type						int,
				id							nvarchar(16),
				DocumentDate				nvarchar(16),
				DocumentNo					nvarchar(16),
				CompanyName					nvarchar(255),
				Subject						nvarchar(1000),
				PageCnt						int,
				UserPkID					nvarchar(16),
				StatusID					nvarchar(16),
				IsReturn					nvarchar(1),
				ReturnDate					datetime,
				ReturnDepartments			nvarchar(max),
				ReturnEmployees				nvarchar(max),
				ReturnDescr					nvarchar(1000),
				DocumentTypeID				nvarchar(16),
				IsAll						nvarchar(1),
				IsEmp						nvarchar(1)
			 )
	EXEC sp_xml_removedocument @idoc 	
	
	SELECT	
	@type = type,
	@id = id,
	@DocumentDate = DocumentDate,
	@DocumentNo = DocumentNo,
	@CompanyName = CompanyName,
	@Subject = Subject,
	@PageCnt = PageCnt,
	@UserPkID = UserPkID,
	@StatusID = StatusID,
	@IsReturn = IsReturn,
	@ReturnDate = ReturnDate,
	@ReturnDepartments = ReturnDepartments,
	@ReturnEmployees = ReturnEmployees,
	@ReturnDescr = ReturnDescr,
	@DocumentTypeID = DocumentTypeID,
	@IsAll = IsAll,
	@IsEmp = IsEmp
	FROM #tmp
	
	BEGIN TRANSACTION

	IF @type = 1			-- new record
	BEGIN
		EXEC dbo.spsmm_LastSequence_SEL 'docDocument', @id OUTPUT
		INSERT INTO docDocument VALUES (@id, @DocumentDate, @DocumentNo, @CompanyName, @Subject, @PageCnt, 
		N'', GETDATE(), @UserPkID, @StatusID, @IsReturn, @ReturnDate, CASE WHEN @DocumentTypeID = '2' THEN @ReturnDepartments ELSE N'' END, N'', @DocumentTypeID)

		IF(@IsAll = 'Y')
		BEGIN
			INSERT INTO docDocumentEmployee VALUES (@ID, N'1', N'1', GETDATE())
		END
		ELSE
		BEGIN
			IF(@IsReturn = 'Y')
			BEGIN
				UPDATE docDocument SET ReturnDate = @ReturnDate, ReturnDescr = @ReturnDescr WHERE DocumentPkID = @id

				IF(@ReturnDepartments <> '')
				BEGIN
					SET @ReturnDepartments = SUBSTRING(@ReturnDepartments, 2, len(@ReturnDepartments)-2)

					DECLARE @depid VARCHAR(16)

					DECLARE dep_cur CURSOR FOR 
					SELECT Name FROM splitstringbyseparator(@ReturnDepartments, ',')
		
					OPEN dep_cur  
					FETCH NEXT FROM dep_cur INTO @depid  

					WHILE @@FETCH_STATUS = 0  
					BEGIN  
						  INSERT INTO docDocumentEmployee VALUES (@id, @depid , N'', GETDATE())

						  FETCH NEXT FROM dep_cur INTO @depid 
					END 

					CLOSE dep_cur  
					DEALLOCATE dep_cur 
				END
				ELSE IF (@ReturnEmployees <> '')
				BEGIN
					SET @ReturnEmployees = SUBSTRING(@ReturnEmployees, 2, len(@ReturnEmployees)-2)

					DECLARE @empid VARCHAR(16)

					DECLARE emp_cur CURSOR FOR 
					SELECT Name FROM splitstringbyseparator(@ReturnEmployees, ',')
		
					OPEN emp_cur  
					FETCH NEXT FROM emp_cur INTO @empid

					WHILE @@FETCH_STATUS = 0  
					BEGIN  
							INSERT INTO docDocumentEmployee VALUES(@id, N'', @empid, GETDATE())

							FETCH NEXT FROM emp_cur INTO @empid
					END 

					CLOSE emp_cur  
					DEALLOCATE emp_cur 
				END
			END
			ELSE IF(@IsEmp = 'Y')
				BEGIN
				SET @ReturnEmployees = SUBSTRING(@ReturnEmployees, 2, len(@ReturnEmployees)-2)

				DECLARE @empid_alt VARCHAR(16)

				DECLARE emp_cur_alt CURSOR FOR 
				SELECT Name FROM splitstringbyseparator(@ReturnEmployees, ',')
		
				OPEN emp_cur_alt  
				FETCH NEXT FROM emp_cur_alt INTO @empid_alt  

				WHILE @@FETCH_STATUS = 0  
				BEGIN  
					  INSERT INTO docDocumentEmployee VALUES (@id, N'', @empid_alt, GETDATE())

					  FETCH NEXT FROM emp_cur_alt INTO @empid_alt
				END 

				CLOSE emp_cur_alt  
				DEALLOCATE emp_cur_alt 
			END
		END
	END
	ELSE IF @type = 0		-- update record
	BEGIN
		UPDATE docDocument SET 
		DocumentDate = @DocumentDate,
		DocumentNo = @DocumentNo,
		CompanyName = @CompanyName,
		Subject = @Subject,
		PageCnt = @PageCnt,
		--DocumentFilePath = N'',
		UserPkID = @UserPkID,
		StatusID = @StatusID,
		IsReturn = @IsReturn,
		ReturnDate = @ReturnDate,
		ReturnDepartmentPkID = CASE WHEN @DocumentTypeID = '2' THEN @ReturnDepartments ELSE N'' END,
		ReturnDescr = @ReturnDescr
		WHERE DocumentPkID = @id
		
		IF(@IsAll = 'Y')
		BEGIN
			DELETE FROM docDocumentEmployee WHERE DocumentPkID = @id

			INSERT INTO docDocumentEmployee VALUES (@ID, N'1', N'1', GETDATE())
		END
		ELSE
		BEGIN
			IF(@IsReturn = 'Y')
			BEGIN
				UPDATE docDocument SET ReturnDate = @ReturnDate, ReturnDescr = @ReturnDescr WHERE DocumentPkID = @id

				IF(@ReturnDepartments <> '')
				BEGIN
					SET @ReturnDepartments = SUBSTRING(@ReturnDepartments, 2, len(@ReturnDepartments)-2)

					DELETE FROM docDocumentEmployee WHERE DocumentPkID = @id 
					AND DepartmentPkID NOT IN (SELECT Name FROM splitstringbyseparator(@ReturnDepartments, ','))

					DECLARE @depid1 VARCHAR(16)

					DECLARE dep_cur CURSOR FOR 
					SELECT Name FROM splitstringbyseparator(@ReturnDepartments, ',')
		
					OPEN dep_cur  
					FETCH NEXT FROM dep_cur INTO @depid1  

					WHILE @@FETCH_STATUS = 0  
					BEGIN  
						  IF ((SELECT COUNT(*) FROM docDocumentEmployee WHERE DocumentPkID = @id AND DepartmentPkID = @depid1) = 0)
						  BEGIN
							INSERT INTO docDocumentEmployee VALUES (@id, @depid1 , N'', GETDATE())
						  END

						  FETCH NEXT FROM dep_cur INTO @depid1 
					END 

					CLOSE dep_cur  
					DEALLOCATE dep_cur 
				END
				ELSE IF (@ReturnEmployees <> '')
				BEGIN
					SET @ReturnEmployees = SUBSTRING(@ReturnEmployees, 2, len(@ReturnEmployees)-2)

					DELETE FROM docDocumentEmployee WHERE DocumentPkID = @id 
					AND EmployeeInfoPkID NOT IN (SELECT Name FROM splitstringbyseparator(@ReturnEmployees, ','))

					DECLARE @empid1 VARCHAR(16)

					DECLARE emp_cur CURSOR FOR 
					SELECT Name FROM splitstringbyseparator(@ReturnEmployees, ',')
		
					OPEN emp_cur  
					FETCH NEXT FROM emp_cur INTO @empid1

					WHILE @@FETCH_STATUS = 0  
					BEGIN  
							IF ((SELECT COUNT(*) FROM docDocumentEmployee WHERE DocumentPkID = @id AND EmployeeInfoPkID = @empid1) = 0)
							BEGIN
								INSERT INTO docDocumentEmployee VALUES(@id, N'', @empid1, GETDATE())
							END

							FETCH NEXT FROM emp_cur INTO @empid1
					END 

					CLOSE emp_cur  
					DEALLOCATE emp_cur 
				END
			END
			ELSE IF(@IsEmp = 'Y')
				BEGIN
				SET @ReturnEmployees = SUBSTRING(@ReturnEmployees, 2, len(@ReturnEmployees)-2)

				DELETE FROM docDocumentEmployee WHERE DocumentPkID = @id 
				AND EmployeeInfoPkID NOT IN (SELECT Name FROM splitstringbyseparator(@ReturnEmployees, ','))

				DECLARE @empid_alt1 VARCHAR(16)

				DECLARE emp_cur_alt CURSOR FOR 
				SELECT Name FROM splitstringbyseparator(@ReturnEmployees, ',')
		
				OPEN emp_cur_alt  
				FETCH NEXT FROM emp_cur_alt INTO @empid_alt1  

				WHILE @@FETCH_STATUS = 0  
				BEGIN  
					  IF ((SELECT COUNT(*) FROM docDocumentEmployee WHERE DocumentPkID = @id AND EmployeeInfoPkID = @empid_alt1) = 0)
					  BEGIN
						INSERT INTO docDocumentEmployee VALUES (@id, N'', @empid_alt1, GETDATE())
					  END

					  FETCH NEXT FROM emp_cur_alt INTO @empid_alt1
				END 

				CLOSE emp_cur_alt  
				DEALLOCATE emp_cur_alt 
			END
		END

	END

	COMMIT TRANSACTION

	SELECT @id as DocumentPkID

END
GO
