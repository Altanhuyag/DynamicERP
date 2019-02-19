IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_DepartmentPosition_UPD')
DROP PROC sphrm_DepartmentPosition_UPD
GO
CREATE PROC sphrm_DepartmentPosition_UPD
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
		
		SELECT * INTO #tmpNew
		FROM OPENXML (@idoc,'//DepartmentPosition',2)
		WITH ( 
			   DepartmentPkID	    nvarchar(16),
			   PositionName				nvarchar(16),
			   PositionCount				int
			 )
		
	EXEC sp_xml_removedocument @idoc 
	
    SELECT @DepartmentPkID=DepartmentPkID FROM #tmp	
    
	select @YearPkID = ConfigValue from smmConfig where ModuleID='HRM' and ConfigID = 'YearPkID'

	delete hrmDepartmentPosition where DepartmentPkID = @DepartmentPkID
	
	insert into hrmDepartmentPosition (YearPkID,DepartmentPkID,PositionPkID,PositionCount)
	select @YearPkID,@DepartmentPkID,PositionName,PositionCount from #tmpNew where len(PositionName)<>0

END


GO
