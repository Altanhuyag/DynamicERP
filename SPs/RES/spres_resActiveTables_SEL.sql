
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spres_resActiveTables_SEL')
DROP PROC spres_resActiveTables_SEL
GO
CREATE PROC spres_resActiveTables_SEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 

BEGIN
	
	SELECT TablePkID FROM resOrderInfo WHERE Status = 0

END
GO
