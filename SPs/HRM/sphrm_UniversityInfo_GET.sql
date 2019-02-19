IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_UniversityInfo_GET')
DROP PROC sphrm_UniversityInfo_GET
GO
CREATE PROC sphrm_UniversityInfo_GET
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 
  
BEGIN

SET NOCOUNT ON
	DECLARE @idoc				INT,
			@CountryID			nvarchar(16)
			
			
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH ( CountryID		nvarchar(16) )
	EXEC sp_xml_removedocument @idoc 

	SELECT @CountryID=CountryID FROM #tmp

	SELECT A.*, B.CountryName FROM hrmUniversityInfo A
	LEFT JOIN hrmCountryInfo B ON A.CountryID=B.CountryID
	where A.CountryID = @CountryID

END
GO
