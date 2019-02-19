IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_DepartmentPosition_SEL')
DROP PROC sphrm_DepartmentPosition_SEL
GO
CREATE PROC sphrm_DepartmentPosition_SEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
)
WITH ENCRYPTION
AS
  
BEGIN
	SET NOCOUNT ON
	DECLARE @idoc				INT,			
			@DepartmentPkID	    nvarchar(16),
			@YearPkID			nvarchar(16)
			
			
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH ( DepartmentPkID	    nvarchar(16))
	EXEC sp_xml_removedocument @idoc 

    SELECT @DepartmentPkID=DepartmentPkID FROM #tmp	

	select @YearPkID = ConfigValue from smmConfig where ModuleID='HRM' and ConfigID = 'YearPkID'

	select DepartmentPkID,A.PositionPkID,A.PositionPkID as PositionName,PositionCount from hrmDepartmentPosition  A
	inner join hrmPositionInfo B on A.PositionPkiD = B.PositionPkID
	where A.DepartmentPkID=@DepartmentPkID
	and A.YearPkID = @YearPkID
END
GO
