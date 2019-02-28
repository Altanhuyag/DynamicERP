IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_UniversityInfo_UPD')
DROP PROC sphrm_UniversityInfo_UPD
GO
CREATE PROC sphrm_UniversityInfo_UPD
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
			@UniversityPkID		NVARCHAR(16),
			@UniversityName		NVARCHAR(250),
			@CountryID			Nvarchar(20)
	
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (  Adding					TinyInt,
				UniversityPkID			NVARCHAR(16),
				UniversityName			NVARCHAR(250),
				CountryID				Nvarchar(20))
	EXEC sp_xml_removedocument @idoc 	

	
	SELECT @Adding=Adding, @UniversityPkID=UniversityPkID, @UniversityName=UniversityName, @CountryID=CountryID FROM #tmp
   
	
	IF @Adding=0 BEGIN
	
		IF (SELECT COUNT(*) FROM hrmUniversityInfo WHERE UniversityName=@UniversityName) > 0
			BEGIN
 				RAISERROR ('Их, дээд сургуулийн нэр давхардаж байна !', 16, 1)
				RETURN (1)
			END
		
		EXEC dbo.spsmm_LastSequence_SEL 'hrmUniversityInfo', @UniversityPkID output

		INSERT INTO hrmUniversityInfo(UniversityPkID, UniversityName, CountryID)		
		VALUES (@UniversityPkID, @UniversityName, @CountryID) 
	END
	ELSE
		UPDATE hrmUniversityInfo
		SET UniversityName=@UniversityName,
			CountryID=@CountryID
		WHERE UniversityPkID=@UniversityPkID
END
GO
