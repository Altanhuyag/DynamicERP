IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_RetireEmployee_SEL')
DROP PROC sphrm_RetireEmployee_SEL
GO

CREATE PROC sphrm_RetireEmployee_SEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 
BEGIN
	
	declare @YearPkID nvarchar(16)

	select @YearPkID = ConfigValue from smmConfig where ModuleID='HRM' and ConfigID ='YearPkID'

	SELECT A.*,D.DepartmentName,P.PositionName,PG.PositionGroupName , C.ValueStr1 as MaleName,year(getdate())-year(EI.Birthday) as Age FROM hrmRetiredEmployee A
	inner join hrmEmployeeInfo EI on A.EmployeeInfoPkID = EI.EmployeeInfoPkID and EI.YearPkID = @YearPkID
	inner join hrmDepartmentInfo D on EI.DepartmentPkID = D.DepartmentPkID	
	inner join hrmPositionInfo P on EI.PositionPkID = P.PositionPkID
	inner join hrmPositionGroup PG on P.PositionGroupPkID = PG.PositionGroupPkID
	inner join (select * from smmConstants where ConstType='hrmMaleInfo') as C on EI.Gender = C.ConstKey	
	
END

GO
