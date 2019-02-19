IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_JobTimeTableInfo_SEL')
DROP PROC sphrm_JobTimeTableInfo_SEL
GO
CREATE PROC sphrm_JobTimeTableInfo_SEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 

BEGIN
	SELECT *FROM hrmJobTimeTableInfo 
END

GO
