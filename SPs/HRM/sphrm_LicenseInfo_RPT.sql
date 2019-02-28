IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_LicenseInfo_RPT')
DROP PROC sphrm_LicenseInfo_RPT
GO
CREATE PROC sphrm_LicenseInfo_RPT
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 

BEGIN

	SET NOCOUNT ON
	DECLARE @idoc				Int,
			@DepartmentPkID		nvarchar(250),
			@RegisterNo			nvarchar(50),
			@Condition			nvarchar(1)
	
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (	DepartmentPkID		nvarchar(250)	)
	EXEC sp_xml_removedocument @idoc 	
	
	SELECT	@DepartmentPkID=isnull(DepartmentPkID,'')	FROM #tmp
	
	
	select A.*,B.ValueStr1 as LicenseInfoTypeName,EI.LastName,EI.FirstName,EI.RegisterNo,Po.PositionName,DI.DepartmentName from hrmLicenseInfo A
	inner join (select * from smmConstants where ModuleID='HRM' and ConstType='hrmLicense') B on B.ValueNum = A.LicenseInfoTypeID
	inner join hrmEmployeeInfo EI on A.EmployeeInfoPkID = EI.EmployeeInfoPkID
	left join hrmPositionInfo Po on EI.PositionPkID = Po.PositionPkID
	inner join hrmDepartmentInfo DI on EI.DepartmentPkID = DI.DepartmentPkID
	where case when @DepartmentPkID='' then '' else EI.DepartmentPkID end = case when @DepartmentPkID='' then '' else @DepartmentPkID end
END
GO
