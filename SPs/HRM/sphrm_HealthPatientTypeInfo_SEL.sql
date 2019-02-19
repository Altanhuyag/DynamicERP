IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_HealthPatientTypeInfo_SEL')
DROP PROC sphrm_HealthPatientTypeInfo_SEL
GO
CREATE PROC sphrm_HealthPatientTypeInfo_SEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 

BEGIN
	SET NOCOUNT ON
	
	select * from hrmHealthPatientTypeInfo

	
END
GO
