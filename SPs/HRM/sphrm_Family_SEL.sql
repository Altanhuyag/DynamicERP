IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_Family_SEL')
DROP PROC sphrm_Family_SEL
GO
CREATE PROC sphrm_Family_SEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 

BEGIN
	SET NOCOUNT ON	
	select A.*,C.FirstName as FirstName1, B.FamilyMemberName,D.DepartmentName,P.PositionName,YEAR(getdate())-YEAR(A.BirthDay) as Age,
	C.RegisterNo from hrmFamily A
	left join hrmFamilyMemberInfo B on A.FamilyMemberPkID=B.FamilyMemberPkID
	left join hrmEmployeeInfo C on A.EmployeeInfoPkID=C.EmployeeInfoPkID
	left join hrmDepartmentInfo D on C.DepartmentPkID=D.DepartmentPkID
	left join hrmPositionInfo P on C.PositionPkID=P.PositionPkID	
END
GO
