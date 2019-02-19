IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_DepartmentInfo_Order_GET')
DROP PROC sphrm_DepartmentInfo_Order_GET
GO
CREATE PROC sphrm_DepartmentInfo_Order_GET
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 

BEGIN
DECLARE @idoc			INT,
		@DepartmentPkID	nvarchar(16),
		@SortedOrder nvarchar(16),
		@YearPkID nvarchar(16)
			
			
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (	DepartmentPkID		nvarchar(20))
	EXEC sp_xml_removedocument @idoc
	
	select @DepartmentPkID = DepartmentPkID from #tmp
	
	select @YearPkID = ConfigValue from smmConfig where ModuleID='HRM' and ConfigID ='YearPkID'

	select @SortedOrder = Sortedorder from hrmDepartmentInfo where DepartmentPkID = @DepartmentPkID and YearPkID = @YearPkID

	SELECT A.*,P.PositionName,B.DepartmentName as ParentDepartmentName,EI.EventInfoName FROM hrmDepartmentInfo A
	left join hrmDepartmentInfo B on A.ParentPkID = B.DepartmentPkID
	left join hrmPositionInfo P on A.ControlPositionPkID=P.PositionPkID
	left join hrmEventInfo EI on A.EventInfoPkID = EI.EventInfoPkID
	where A.SortedOrder like @SortedOrder+'%'
	and A.YearPkID = @YearPkID
END
GO
