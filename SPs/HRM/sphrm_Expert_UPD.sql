IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_Expert_UPD')
DROP PROC sphrm_Expert_UPD
GO
CREATE PROC sphrm_Expert_UPD
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc				int,
			@Adding				int,
			@EmployeeInfoPkID	NVARCHAR(16),
			@ExpertPkID			nvarchar(16),
			@Title				nvarchar(250),
			@Organization		nvarchar(250),
			@InDate				DateTime,
			@Period				nvarchar(50),
			@CertNo				nvarchar(50)
	
	
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (	
				Adding				Int,
				EmployeeInfoPkID	NVARCHAR(16),
				ExpertPkID			nvarchar(16),
				Title				nvarchar(250),
				Organization		nvarchar(250),
				InDate				DateTime,
				Period				nvarchar(50),
				CertNo				nvarchar(50))

	EXEC sp_xml_removedocument @idoc 	
	
	SELECT	@Adding=Adding, @EmployeeInfoPkID=EmployeeInfoPkID, @ExpertPkID=ExpertPkID, @Title=Title, 
			@Organization=Organization, @InDate=InDate, @Period=Period, @CertNo=CertNo 	FROM #tmp	
	
	IF(@EmployeeInfoPkID = '' or @EmployeeInfoPkID is null)
	BEGIN
		RAISERROR(N'Ажилтнаа сонгоно уу!', 16, 1)
		RETURN
	END

	IF @Adding=0 BEGIN

		EXEC dbo.spsmm_LastSequence_SEL 'hrmExpert', @ExpertPkID output

		INSERT INTO hrmExpert
							(	
								EmployeeInfoPkID,
								ExpertPkID,
								Title,
								Organization,
								InDate,
								Period,
								CertNo)
		
		VALUES (				@EmployeeInfoPkID,
								@ExpertPkID,
								@Title,
								@Organization,
								@InDate,
								@Period,
								@CertNo)
	END
	ELSE 
		UPDATE	hrmExpert
        SET		EmployeeInfoPkID=@EmployeeInfoPkID,
				Title=@Title,
				Organization=@Organization,
				InDate=@InDate,
				Period=@Period,
				CertNo=@CertNo
		WHERE ExpertPkID=@ExpertPkID
END
GO
