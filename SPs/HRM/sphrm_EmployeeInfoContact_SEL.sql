IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_EmployeeInfoContact_SEL')
DROP PROC sphrm_EmployeeInfoContact_SEL
GO
CREATE PROC sphrm_EmployeeInfoContact_SEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 

BEGIN
	SET NOCOUNT ON
	
	select A.*,B.FirstName AS FirstName,P.PositionName,
	D.DepartmentName,C.ValueStr1 as StatusName,P1.PositionGroupName,P.PositionName,CC.ValueStr1 as SalaryTypeName,CCC.ValueStr1 as WorkingStatusName,
	case when A.EndDate<getdate() then N'Хөдөлмөрийн гэрээг сунгах шаардлага' 
	else N'Хөдөлмөрийн гэрээ хэвийн' end As ContactStatusName 
	from hrmEmployeeInfoContact A
	left join hrmEmployeeInfo B on A.EmployeeInfoPkID = B.EmployeeInfoPkID
	left join hrmDepartmentInfo D on A.DepartmentPkID = D.DepartmentPkID
	left join hrmPositionInfo P on A.PositionPkID = P.PositionPkID
	left join hrmPositionGroup P1 on A.PositionGroupPkID=P1.PositionGroupPkID
	left join (select * from smmConstants where ConstType='hrmEmployeeStatus') C on A.Status = C.ConstKey
	left join (select * from smmConstants where ConstType='hrmSalaryType') CC on A.SalaryTypeID = CC.ValueNum
	left join (select * from smmConstants where ConstType='hrmWorkingStatus') CCC on A.WorkingStatusID = CCC.ValueNum
	
	
	
END 
GO
