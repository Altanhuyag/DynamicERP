IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_Graduate_UPD')
DROP PROC sphrm_Graduate_UPD
GO
CREATE PROC sphrm_Graduate_UPD
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc				Int,
			@Adding				TinyInt,
			@GraduatePkID		NVARCHAR(16),
			@EmployeeInfoPkID	NVARCHAR(16),
			@EnteredDate		DateTime,
			@FinishedDate		DateTime,
			@UniversityPkID		nvarchar(50),
			@ProfessionPkID		nvarchar(16),
			@EducationPkID		nvarchar(16),
			@Location			nvarchar(250),
			@DiplomNo			nvarchar(50),
			@CountryID			nvarchar(16),
			@IsHighSchool		nvarchar(1)
	
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (  Adding				TinyInt,
				GraduatePkID		NVARCHAR(16),
				EmployeePkID		NVARCHAR(16),
				EnteredDate			DateTime,
				FinishedDate		DateTime,
				UniversityPkID		nvarchar(50),
				ProfessionPkID		nvarchar(16),
				EducationPkID		nvarchar(16),
				Location			nvarchar(250),
				DiplomNo			nvarchar(50),
				CountryID			nvarchar(16),
				IsHighSchool		nvarchar(1))
	EXEC sp_xml_removedocument @idoc 	
		
	SELECT	@Adding=Adding,
			@GraduatePkID=GraduatePkID,
			@EmployeeInfoPkID=EmployeePkID,
			@EnteredDate=EnteredDate,
			@FinishedDate=FinishedDate,
			@UniversityPkID=UniversityPkID,
			@ProfessionPkID=ProfessionPkID,
			@EducationPkID=EducationPkID,
			@Location=Location,
			@DiplomNo=DiplomNo,
			@CountryID = CountryID,
			@IsHighSchool = IsHighSchool
	FROM #tmp
   
	IF(@EmployeeInfoPkID = '' or @EmployeeInfoPkID is null)
	BEGIN
		RAISERROR(N'Ажилтнаа сонгоно уу!', 16, 1)
		RETURN
	END

	IF(@UniversityPkID = '' or @UniversityPkID is null)
	BEGIN
		RAISERROR(N'Сургуулиа сонгоно уу!', 16, 1)
		RETURN
	END

	IF(@ProfessionPkID = '' or @ProfessionPkID is null)
	BEGIN
		RAISERROR(N'Мэргэжлээ сонгоно уу!', 16, 1)
		RETURN
	END

	IF(@EducationPkID = '' or @EducationPkID is null)
	BEGIN
		RAISERROR(N'Мэргэжлийн зэрэгээ сонгоно уу!', 16, 1)
		RETURN
	END

	IF(@CountryID = '' or @CountryID is null)
	BEGIN
		RAISERROR(N'Төгссөн улсаа сонгоно уу!', 16, 1)
		RETURN
	END
	
	IF @Adding=0 BEGIN
		
		EXEC dbo.spsmm_LastSequence_SEL 'hrmGraduate', @GraduatePkID output

		INSERT INTO hrmGraduate(GraduatePkID, 
								EmployeePkID, 
								EnteredDate, 
								FinishedDate, 
								UniversityPkID, 
								ProfessionPkID, 
								EducationPkID, 
								Location,
								DiplomNo,
								CountryID,
								IsHighSchool)
								
		VALUES (@GraduatePkID,
				@EmployeeInfoPkID,
				@EnteredDate,
				@FinishedDate,
				@UniversityPkID,
				@ProfessionPkID,
				@EducationPkID,
				@Location,
				@DiplomNo,
				@CountryID,
				@IsHighSchool)
	END
	ELSE
		UPDATE hrmGraduate
		SET EnteredDate=@EnteredDate, 
			FinishedDate=@FinishedDate, 
			EmployeePkID=@EmployeeInfoPkID,
			UniversityPkID=@UniversityPkID, 
			ProfessionPkID=@ProfessionPkID, 
			EducationPkID=@EducationPkID, 
			Location=@Location,
			DiplomNo=@DiplomNo,
			CountryID = @CountryID,
			IsHighSchool = @IsHighSchool
		WHERE GraduatePkID=@GraduatePkID
END
GO
