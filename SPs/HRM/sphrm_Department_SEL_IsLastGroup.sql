IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_Department_SEL_IsLastGroup')
DROP PROC sphrm_Department_SEL_IsLastGroup
GO
CREATE PROC sphrm_Department_SEL_IsLastGroup
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 

BEGIN
	declare @YearPkID nvarchar(16)

	select @YearPkID = ConfigValue from smmConfig where ModuleID='HRM' and ConfigID ='YearPkID'

	SELECT * FROM hrmDepartmentInfo where YearPkID = @YearPkID
END
GO
