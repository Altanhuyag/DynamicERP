IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_LanguageInfo_SEL')
DROP PROC sphrm_LanguageInfo_SEL
GO
CREATE PROC sphrm_LanguageInfo_SEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc			INT
			
			
	select * from hrmLanguageInfo
END
GO
