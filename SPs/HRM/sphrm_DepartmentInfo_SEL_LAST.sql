IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_DepartmentInfo_SEL_LAST')
DROP PROC sphrm_DepartmentInfo_SEL_LAST
GO
CREATE PROC sphrm_DepartmentInfo_SEL_LAST
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
		WITH (	DepartmentPkID		nvarchar(20))
	EXEC sp_xml_removedocument @idoc
	
	select @DepartmentPkID = DepartmentPkID from #tmp

	select @YearPkID = ConfigValue from smmConfig where ModuleID='HRM' and ConfigID ='YearPkID'
	
	SELECT A.*,P.PositionName FROM hrmDepartmentInfo A
	left join hrmPositionInfo P on A.ControlPositionPkID=P.PositionPkID	
	where ParentPkID = @DepartmentPkID
	and YearPkID = @YearPkID
	
END
GO
