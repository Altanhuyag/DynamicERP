IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_ProfessionInfo_DEL')
DROP PROC sphrm_ProfessionInfo_DEL
GO
CREATE PROC sphrm_ProfessionInfo_DEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS
  
BEGIN
	SET NOCOUNT ON
	DECLARE @idoc				INT,			
			@ProfessionPkID		nvarchar(16),
			@Cnt				Int,
			@Descr				nvarchar(MAX),
			@LogUserGroupID		nvarchar(16)	
			
			
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH ( ProfessionPkID	nvarchar(16),
				LogUserGroupID		nvarchar(16) )
	EXEC sp_xml_removedocument @idoc 

	SELECT @ProfessionPkID=ProfessionPkID, @LogUserGroupID=LogUserGroupID FROM #tmp
	--EXEC SystemManager.dbo.spsmm_RecordIsUsed @LogUserGroupID, 'hrmProfessionInfo',@ProfessionPkID, @Cnt output, @Descr output
   
	delete A	
	from hrmProfessionInfo A
		INNER JOIN #tmp B ON A.ProfessionPkID=B.ProfessionPkID

END
GO
