IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_RetireEmployeeAge_SEL')
DROP PROC sphrm_RetireEmployeeAge_SEL
GO

CREATE PROC sphrm_RetireEmployeeAge_SEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 
BEGIN
	
	SELECT A.*,D.DepartmentName,P.PositionName,PG.PositionGroupName , 
	C.ValueStr1 as MaleName,EI.EmployeePicture ImageFile,year(getdate())-year(A.Birthday) as Age,A.LastName+N' овогтой '+A.FirstName FullName FROM hrmEmployeeInfo A
	inner join hrmDepartmentInfo D on A.DepartmentPkID = D.DepartmentPkID	
	inner join hrmPositionInfo P on A.PositionPkID = P.PositionPkID
	inner join hrmPositionGroup PG on P.PositionGroupPkID = PG.PositionGroupPkID
	inner join (select * from smmConstants where ConstType='hrmMaleInfo') as C on A.Gender = C.ConstKey
	left join hrmEmployeeImage EI on A.EmployeeInfoPkID = EI.EmployeePkID
	where year(getdate()- datepart(dy,A.Birthday)) - YEAR(A.Birthday) between 55 and 60 and A.Status not in (2,3,5)
END

GO
