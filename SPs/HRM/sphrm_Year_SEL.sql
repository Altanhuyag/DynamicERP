IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_Year_SEL')
DROP PROC sphrm_Year_SEL
GO
CREATE PROC sphrm_Year_SEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 

BEGIN

		select *,Convert(nvarchar,Year1) + '-' + Convert(nvarchar,Year2) + N' Жил' as YearName from hrmYearInfo

END
GO
