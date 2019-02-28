IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_SheetInfo_SEL')
DROP PROC sphrm_SheetInfo_SEL
GO
CREATE PROC sphrm_SheetInfo_SEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 

BEGIN
	SET NOCOUNT ON
			
	select * from hrmSheetInfo
END
GO
