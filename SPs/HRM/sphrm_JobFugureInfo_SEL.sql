IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_JobFugureInfo_SEL')
DROP PROC sphrm_JobFugureInfo_SEL
GO
CREATE PROC sphrm_JobFugureInfo_SEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 

BEGIN
	SELECT *FROM hrmJobFugureInfo
 
END

GO
