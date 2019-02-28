IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_UniversityInfo_SEL')
DROP PROC sphrm_UniversityInfo_SEL
GO
CREATE PROC sphrm_UniversityInfo_SEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 
  
BEGIN
	SELECT A.*, B.CountryName FROM hrmUniversityInfo A
	LEFT JOIN hrmCountryInfo B ON A.CountryID=B.CountryID	
END
GO
