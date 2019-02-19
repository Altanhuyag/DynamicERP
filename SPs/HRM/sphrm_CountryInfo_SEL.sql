IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_CountryInfo_SEL')
DROP PROC sphrm_CountryInfo_SEL
GO
CREATE PROC sphrm_CountryInfo_SEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 

BEGIN
	SELECT CountryID, CountryName FROM hrmCountryInfo order by CountryName
END

GO
