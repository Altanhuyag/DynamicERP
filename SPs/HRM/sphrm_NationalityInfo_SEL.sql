IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_SumInfo_GET')
DROP PROC sphrm_SumInfo_GET
GO
CREATE PROC sphrm_NationalityInfo_SEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 

BEGIN
	SELECT * FROM hrmNationalityInfo
END
GO
