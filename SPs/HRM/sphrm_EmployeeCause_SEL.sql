IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_EmployeeCause_SEL')
DROP PROC sphrm_EmployeeCause_SEL
GO
CREATE PROC sphrm_EmployeeCause_SEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 

BEGIN
	declare @YearPkID nvarchar(16)
	
	select @YearPkID = ConfigValue from smmConfig where ModuleID='HRM' and ConfigID ='YearPkID'

	select A.*,	B.FirstName AS FirstName,B.RegisterNo,C.DepartmentName,D.PositionName,E.FreedomTypeName,HPT.PatientTypeName,
	CI.CountryInfoName,Ai.AimagName
	from hrmEmployeeCause A
	inner join hrmEmployeeInfo B on A.EmployeeInfoPkID=B.EmployeeInfoPkID
	left join hrmDepartmentInfo C on B.DepartmentPkID=C.DepartmentPkID
	left join hrmPositionInfo D on B.PositionPkID=D.PositionPkID
	left join hrmFreedomTypeInfo E on A.FreedomTypePkID=E.FreedomTypePkID
	left join hrmHealthPatientTypeInfo HPT on A.PatientTypePkID = HPT.PatientTypePkID
	left join hrmCountryInfo CI on A.CountryInfoPkID = CI.CountryInfoPkID
	left join hrmAimagInfo AI on A.AimagID = AI.AimagID
END



GO
