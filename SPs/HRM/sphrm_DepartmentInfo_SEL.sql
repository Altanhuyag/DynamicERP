IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_DepartmentInfo_SEL')
DROP PROC sphrm_DepartmentInfo_SEL
GO
CREATE PROC sphrm_DepartmentInfo_SEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
)
WITH ENCRYPTION
AS
  
BEGIN
	declare 
	@YearPkID nvarchar(16)

	select @YearPkID = ConfigValue from smmConfig where ModuleID='HRM' and ConfigID ='YearPkID'

	SELECT 'N' as IsCheck,A.*,isnull(B.DepartmentName,'') as ParentDepartmentName,P.PositionName,EI.EventInfoName FROM hrmDepartmentInfo A
	left join hrmDepartmentInfo B on A.ParentPkID = B.DepartmentPkID	
	left join hrmPositionInfo  P on A.ControlPositionPkID=P.PositionPkID
	left join hrmEventInfo EI on EI.EventInfoPkID = A.EventInfoPkID
	where A.YearPkID = @YearPkID
	order by A.SortNo
END

GO
