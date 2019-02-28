IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_DepartmentInfo_GET')
DROP PROC sphrm_DepartmentInfo_GET
GO
CREATE PROC sphrm_DepartmentInfo_GET
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 

BEGIN
DECLARE @idoc			INT,
		@DepartmentPkID	nvarchar(16),
		@YearPkID nvarchar(16)
			
			
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (	DepartmentPkID		nvarchar(20),
				CompanyRegisterNo nvarchar(16))
	EXEC sp_xml_removedocument @idoc
	
	select @DepartmentPkID = DepartmentPkID from #tmp

	select @YearPkID = ConfigValue from smmConfig where ModuleID='HRM' and ConfigID ='YearPkID'
	
	SELECT A.*,P.PositionName,B.DepartmentName as ParentDepartmentName FROM hrmDepartmentInfo A
	left join hrmDepartmentInfo B on A.ParentPkID = B.DepartmentPkID
	left join hrmPositionInfo P on A.ControlPositionPkID=P.PositionPkID
	where A.DepartmentPkID = @DepartmentPkID and A.YearPkID = @YearPkID
END
GO
