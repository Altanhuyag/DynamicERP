IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_DepartmentInfoFIRST_SEL')
DROP PROC sphrm_DepartmentInfoFIRST_SEL
GO
CREATE PROC sphrm_DepartmentInfoFIRST_SEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 

BEGIN
	Declare @YearPkID nvarchar(16)

	select @YearPkID = ConfigValue from smmConfig where ModuleID='HRM' and ConfigID ='YearPkID'

	SELECT * FROM hrmDepartmentInfo where YearPkID = @YearPkID

END
GO
