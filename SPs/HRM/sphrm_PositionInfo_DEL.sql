IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_PositionInfo_DEL')
DROP PROC sphrm_PositionInfo_DEL
GO
CREATE PROC sphrm_PositionInfo_DEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS
  
BEGIN
	SET NOCOUNT ON
	DECLARE @idoc				INT,			
			@PositionPkID		nvarchar(16),
			@Cnt				Int,
			@Descr				nvarchar(MAX),
			@LogUserGroupID		nvarchar(16),
			@CreatedProgID		nvarchar(10)
		
			
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH ( PositionPkID		nvarchar(16),
				LogUserGroupID		nvarchar(16),
				CreatedProgID		nvarchar(10) )
	EXEC sp_xml_removedocument @idoc 

	SELECT @PositionPkID=PositionPkID, @LogUserGroupID=LogUserGroupID, @CreatedProgID=CreatedProgID FROM #tmp


	DELETE hrmPositionInfo WHERE PositionPkID=@PositionPkID

	
END
GO
