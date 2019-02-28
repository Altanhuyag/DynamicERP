IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_hrmFamilyParent_RPT')
DROP PROC sphrm_hrmFamilyParent_RPT
GO
CREATE PROC sphrm_hrmFamilyParent_RPT
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 
  
BEGIN

select A.FirstName from hrmEmployeeInfo A
 order by A.FirstName

END
GO
