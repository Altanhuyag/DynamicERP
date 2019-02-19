IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_SkillTypeInfo_SEL')
DROP PROC sphrm_SkillTypeInfo_SEL
GO
CREATE PROC sphrm_SkillTypeInfo_SEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 
  
BEGIN
	SELECT * FROM hrmSkillTypeInfo
END
GO
