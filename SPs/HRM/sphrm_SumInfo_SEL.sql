IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_SumInfo_SEL')
DROP PROC sphrm_SumInfo_SEL
GO
CREATE PROC sphrm_SumInfo_SEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 

BEGIN
	SET NOCOUNT ON
	
	select A.*, B.AimagName from hrmSumInfo A
	left join hrmAimagInfo B on A.AimagID=B.AimagID
	
END
GO
