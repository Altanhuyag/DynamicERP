IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_DocumentInfo_SEL')
DROP PROC sphrm_DocumentInfo_SEL
GO
CREATE PROC sphrm_DocumentInfo_SEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 

BEGIN
	SELECT A.* FROM hrmDocumentInfo A
END

GO
