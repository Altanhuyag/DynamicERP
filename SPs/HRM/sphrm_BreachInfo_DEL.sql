IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_BreachInfo_DEL')
DROP PROC sphrm_BreachInfo_DEL
GO
CREATE PROC sphrm_BreachInfo_DEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc				INT,			
			@BreachPkID			nvarchar(16),
			@Cnt				Int,
			@Descr				nvarchar(MAX),
			@LogUserGroupID		nvarchar(16)
			
			
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH ( BreachPkID		nvarchar(16),
				LogUserGroupID		nvarchar(16) )
	EXEC sp_xml_removedocument @idoc

	SELECT @BreachPkID=BreachPkID, @LogUserGroupID=LogUserGroupID FROM #tmp	

	DELETE A
	FROM hrmBreachInfo A
		INNER JOIN #tmp B ON A.BreachPkID=B.BreachPkID
END
GO
