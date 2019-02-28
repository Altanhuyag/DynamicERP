IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_hrmEmployeeInfoN_RPT')
DROP PROC sphrm_hrmEmployeeInfoN_RPT
GO
CREATE PROC sphrm_hrmEmployeeInfoN_RPT
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 
  
BEGIN


select A.*,P.PositionName,year(GETDATE())-YEAR(Birthday) as Age from hrmEmployeeInfo A
inner join hrmPositionInfo P on A.PositionPkID = P.PositionPkID


END
GO
