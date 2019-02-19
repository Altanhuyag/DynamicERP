IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_LanguageKnowledge_UPD')
DROP PROC sphrm_LanguageKnowledge_UPD
GO
CREATE PROC sphrm_LanguageKnowledge_UPD
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
			@LanguageKnowledgePkID		nvarchar(16),
			@LanguagePkID		nvarchar(16),
			@EmployeeInfoPkID	nvarchar(16),
			@Reading			nvarchar(10),
			@Writing			nvarchar(10),
			@Talking			nvarchar(10),
			@Listening			nvarchar(10)
	
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (  Adding				TinyInt,
				LanguageKnowledgePkID		NVARCHAR(16),
				LanguagePkID		NVARCHAR(16),
				EmployeeInfoPkID	nvarchar(16),
				Reading				NVARCHAR(10),
				Writing				nvarchar(10),
				Talking				nvarchar(10),
				Listening			nvarchar(10))
	EXEC sp_xml_removedocument @idoc 	

	
	SELECT	@Adding=Adding,
			@LanguageKnowledgePkID=LanguageKnowledgePkID,
			@LanguagePkID=LanguagePkID,
			@EmployeeInfoPkID=EmployeeInfoPkID,
			@Reading=Reading,
			@Writing=Writing,
			@Talking=Talking,
			@Listening=Listening
	FROM #tmp
   
	IF(@EmployeeInfoPkID = '' or @EmployeeInfoPkID is null)
	BEGIN
		RAISERROR(N'Ажилтнаа сонгоно уу!', 16, 1)
		RETURN
	END

	IF(@LanguagePkID = '' or @LanguagePkID is null)
	BEGIN
		RAISERROR(N'Хэлээ сонгоно уу!', 16, 1)
		RETURN
	END

	IF @Adding=0 BEGIN
		EXEC spsmm_LastSequence_SEL 'hrmLanguageKnowledge', @LanguageKnowledgePkID output
		
		INSERT INTO hrmLanguageKnowledge(	LanguageKnowledgePkID,
											LanguagePkID, 
											EmployeeInfoPkID, 
											Reading, 
											Writing, 
											Talking, 
											Listening)
		VALUES (@LanguageKnowledgePkID,
				@LanguagePkID, 
				@EmployeeInfoPkID, 
				@Reading, 
				@Writing, 
				@Talking, 
				@Listening)
	END
	ELSE
		UPDATE hrmLanguageKnowledge
		SET LanguagePkID=@LanguagePkID,
			EmployeeInfoPkID=@EmployeeInfoPkID,
			Reading=@Reading,
			Writing=@Writing,
			Talking=@Talking,
			Listening=@Listening
		WHERE LanguageKnowledgePkID=@LanguageKnowledgePkID
END
GO
