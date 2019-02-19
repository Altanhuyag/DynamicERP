IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_Employee_SEL')
DROP PROC sphrm_Employee_SEL
GO

CREATE PROC sphrm_Employee_SEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 
BEGIN
	declare 
	@YearPkID nvarchar(16)

	select @YearPkID = ConfigValue from smmConfig where ModuleID='HRM' and ConfigID = 'YearPkID'

	SELECT A.*,D.DepartmentName,P.PositionName,PG.PositionGroupName , C.ValueStr1 as MaleName,
	EI.EmployeePicture as ImageFile,year(getdate())-year(A.Birthday) as Age,E.EducationName,'N' as IsOnline,
	A.LastName + N' овогтой ' + A.FirstName as FullName FROM hrmEmployeeInfo A
	left join hrmDepartmentInfo D on A.DepartmentPkID = D.DepartmentPkID	
	left join hrmPositionInfo P on A.PositionPkID = P.PositionPkID
	left join hrmPositionGroup PG on A.PositionGroupPkID = PG.PositionGroupPkID
	left join (select * from smmConstants where ConstType='hrmMaleInfo') as C on A.Gender = C.ConstKey
	left join hrmEmployeeImage EI on A.EmployeeInfoPkID = EI.EmployeePkID
	LEFT JOIN hrmEducationInfo E ON A.EducationPkID = E.EducationPkID		
	where A.Status  not in (2,3,5) and A.YearPkID = @YearPkID
	order by FirstName

	
END
GO
