IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_AwardInfo_SEL')
DROP PROC sphrm_AwardInfo_SEL
GO

CREATE PROC sphrm_AwardInfo_SEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 

BEGIN

select A.*, B.AwardTypeInfoName from hrmAwardInfo A
	left join hrmAwardTypeInfo B on A.AwardTypeInfoPkID=B.AwardTypeInfoPkID

END
GO
