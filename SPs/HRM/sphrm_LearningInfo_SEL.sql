IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_LearningInfo_SEL')
DROP PROC sphrm_LearningInfo_SEL
GO
CREATE PROC sphrm_LearningInfo_SEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 

BEGIN
	SET NOCOUNT ON
	
	select * from hrmLearningInfo
	
END

GO
