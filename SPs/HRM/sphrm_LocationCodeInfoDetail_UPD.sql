IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_LocationCodeInfoDetail_UPD')
DROP PROC sphrm_LocationCodeInfoDetail_UPD
GO
CREATE PROC sphrm_LocationCodeInfoDetail_UPD
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS
  
BEGIN
	SET NOCOUNT ON
	DECLARE @idoc				INT,
			@Adding				TinyInt,
			@LocationCodePkID	NVARCHAR(16)
	
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (  Adding				TinyInt,
				LocationCodePkID	NVARCHAR(16))
				
	SELECT * INTO #tmpDetail
		FROM OPENXML (@idoc,'//LocationCodeInfo',2)
		WITH (  Adding				TinyInt,
				DepartmentPkID		NVARCHAR(16),
				IsCheck					NVARCHAR(1)
			 )				
	EXEC sp_xml_removedocument @idoc 	

	
	SELECT @Adding=Adding, @LocationCodePkID=LocationCodePkID FROM #tmp
   
	DELETE FROM hrmLocationDepartmentInfo where LocationCodePkID = @LocationCodePkID
	
	INSERT into hrmLocationDepartmentInfo (DepartmentPkID,LocationCodePkID)
	SELECT DepartmentPkID,@LocationCodePkID from #tmpDetail where IsCheck = 'Y'
	 
END



GO
