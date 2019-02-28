IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_FamilyInfo_RPT')
DROP PROC sphrm_FamilyInfo_RPT
GO
CREATE PROC sphrm_FamilyInfo_RPT
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 

BEGIN
	SET NOCOUNT ON
	select A.*,B.FamilyMemberName,P.PositionName,C.LastName,
	SUBSTRING(C.LastName,1,1)+'.'+A.LastName as Name ,year(getdate())-year(A.BirthDay)as Age
	,H.ConfigValue as Employee , F.ConfigValue as Position,C.RegisterNo
	from hrmFamily A
	left join hrmEmployeeInfo C on A.EmployeeInfoPkID=C.EmployeeInfoPkID
	left join hrmFamilyMemberInfo B on A.FamilyMemberPkID=B.FamilyMemberPkID
	left join hrmPositionInfo P on C.PositionPkID=P.PositionPkID
	
	inner join (select * from smmConstants
    where ModuleID='HRM' and ConstType='hrmMaleInfo' ) M on C.Gender = M.ValueNum
	
	left join (select *  from smmConfig  where ModuleID = 'HRM' and ConfigID = 'EmployeeName1') H on M.ModuleID = H.ModuleID
	left join (select *  from smmConfig  where ModuleID = 'HRM' and ConfigID = 'PositionName1') F on M.ModuleID = F.ModuleID
	where  year(Getdate()) -year(A.BirthDay) <=16
END
GO
