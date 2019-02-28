IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_EducationInfo_SEL')
DROP PROC sphrm_EducationInfo_SEL
GO
CREATE PROC sphrm_EducationInfo_SEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 
  
BEGIN
	SELECT * FROM hrmEducationInfo
END

GO
