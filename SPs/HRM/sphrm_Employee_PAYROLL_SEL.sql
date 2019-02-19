IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_Employee_PAYROLL_SEL')
DROP PROC sphrm_Employee_PAYROLL_SEL
GO

CREATE PROC sphrm_Employee_PAYROLL_SEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 
BEGIN
	
	SELECT A.*,D.DepartmentName,P.PositionName,PG.PositionGroupName , C.ValueStr1 as MaleName,EI.EmployeePicture ImageFile,year(getdate())-year(A.Birthday) as Age,E.EducationName FROM hrmEmployeeInfo A
	left join hrmDepartmentInfo D on A.DepartmentPkID = D.DepartmentPkID	
	left join hrmPositionInfo P on A.PositionPkID = P.PositionPkID
	left join hrmPositionGroup PG on P.PositionGroupPkID = PG.PositionGroupPkID
	left join (select * from smmConstants where ConstType='hrmMaleInfo') as C on A.Gender = C.ConstKey
	left join hrmEmployeeImage EI on A.EmployeeInfoPkID = EI.EmployeePkID
	LEFT JOIN hrmEducationInfo E ON A.EducationPkID = E.EducationPkID
	
END
GO
