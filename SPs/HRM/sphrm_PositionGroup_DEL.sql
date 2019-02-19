IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_PositionGroup_DEL')
DROP PROC sphrm_PositionGroup_DEL
GO
CREATE PROC sphrm_PositionGroup_DEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS
  
BEGIN
	SET NOCOUNT ON
	DECLARE @idoc				INT,			
			@PositionGroupPkID	nvarchar(16),
			@Cnt				Int,
			@Descr				nvarchar(MAX),
			@LogUserGroupID		nvarchar(16)
			
			
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH ( PositionGroupPkID		nvarchar(16),
				LogUserGroupID		nvarchar(16) )
	EXEC sp_xml_removedocument @idoc 

	SELECT @PositionGroupPkID=PositionGroupPkID, @LogUserGroupID=LogUserGroupID FROM #tmp
	
	delete A from hrmPositionGroup A
		INNER JOIN #tmp B ON A.PositionGroupPkID=B.PositionGroupPkID

END
GO
