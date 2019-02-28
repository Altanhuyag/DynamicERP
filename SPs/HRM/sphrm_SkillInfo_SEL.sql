IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_SkillInfo_SEL')
DROP PROC sphrm_SkillInfo_SEL
GO
CREATE PROC sphrm_SkillInfo_SEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 
  
BEGIN
	SELECT A.*,B.SkillTypeName FROM hrmSkillInfo A
	inner join hrmSkillTypeInfo B on A.SkillTypePkID = B.SkillTypePkID
END
GO
