IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_CountryInfo_UPD')
DROP PROC sphrm_CountryInfo_UPD
GO
CREATE PROC sphrm_CountryInfo_UPD
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc			Int,
			@Adding			TinyInt,
			@CountryID		nvarchar(20),
			@CountryName	nvarchar(250)
			
	
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (  Adding			TinyInt,	
				CountryID		nvarchar(20),
				CountryName		nvarchar(250))
					
	EXEC sp_xml_removedocument @idoc 	
	
	SELECT	
			@Adding=Adding,
			@CountryID =CountryID,
			@CountryName =CountryName
			
						
			
	FROM #tmp

	IF @Adding=0 BEGIN
	
		EXEC spsmm_LastSequence_SEL 'hrmCountryInfo', @CountryID output

		INSERT INTO hrmCountryInfo
					(	CountryID,
						CountryName )
		
		VALUES (@CountryID,
				@CountryName )
	END
	ELSE

		UPDATE hrmCountryInfo
		SET CountryName =@CountryName
		WHERE CountryID =@CountryID
END

GO
