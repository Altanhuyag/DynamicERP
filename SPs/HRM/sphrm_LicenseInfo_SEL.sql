IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_LicenseInfo_SEL')
DROP PROC sphrm_LicenseInfo_SEL
GO
CREATE PROC sphrm_LicenseInfo_SEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS

BEGIN
	SELECT A.*,E.FirstName+'.'+substring(E.LastName,1,3) as FirstName,PI.PositionName,E.RegisterNo,D.ValueStr1 as LicenseTypeName FROM hrmLicenseInfo A
	inner join hrmEmployeeInfo E on A.EmployeeInfoPkID = E.EmployeeInfoPkID
	inner join hrmPositionInfo PI on E.PositionPkID = PI.PositionPkID
	inner join (select * from smmConstants where ConstType='hrmLicense') D on A.LicenseInfoTypeID = D.ConstKey
END
GO
