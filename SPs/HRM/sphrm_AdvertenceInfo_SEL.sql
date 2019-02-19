IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_AdvertenceInfo_SEL')
DROP PROC sphrm_AdvertenceInfo_SEL
GO

CREATE PROC sphrm_AdvertenceInfo_SEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 

BEGIN
	select A.*,B.AdvertenceTypeName from hrmAdvertenceInfo A
	inner join hrmAdvertenceTypeInfo B on A.AdvertenceTypeInfoPkID=B.AdvertenceTypeInfoPkID
	 
END
GO
