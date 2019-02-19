IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_LanguageInfo_UPD')
DROP PROC sphrm_LanguageInfo_UPD
GO
CREATE PROC sphrm_LanguageInfo_UPD
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS
  
BEGIN
	SET NOCOUNT ON
	DECLARE @idoc				INT,
			@Adding				TinyInt,
			@LanguagePkID		NVARCHAR(16),
			@LanguageName		NVARCHAR(255)
	
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (  Adding					TinyInt,
				LanguagePkID			NVARCHAR(16),
				LanguageName			NVARCHAR(255))
	EXEC sp_xml_removedocument @idoc 	

	
	SELECT @Adding=Adding, @LanguagePkID=LanguagePkID, @LanguageName=LanguageName FROM #tmp
   
	
	IF @Adding=0 BEGIN
	
		IF (SELECT COUNT(*) FROM hrmLanguageInfo WHERE LanguageName=@LanguageName) > 0
			BEGIN
 				RAISERROR ('Гадаад хэлний нэр давхардаж байна !', 16, 1)
				RETURN (1)		
			END
		exec dbo.spsmm_LastSequence_SEL 'hrmLanguageInfo',@LanguagePkID output

		INSERT INTO hrmLanguageInfo(LanguagePkID, LanguageName)		
		VALUES (@LanguagePkID, @LanguageName) 
	END
	ELSE
		UPDATE hrmLanguageInfo
		SET LanguageName=@LanguageName
		WHERE LanguagePkID=@LanguagePkID 
END


GO
