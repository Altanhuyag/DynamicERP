IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_WorkingHistory_DEL')
DROP PROC sphrm_WorkingHistory_DEL
GO
CREATE PROC sphrm_WorkingHistory_DEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc				INT,
			@WorkingHistoryPkID	nvarchar(16)
			
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (	WorkingHistoryPkID	nvarchar(16))
	EXEC sp_xml_removedocument @idoc

	SELECT @WorkingHistoryPkID=WorkingHistoryPkID FROM #tmp

	DELETE FROM hrmWorkingHistory WHERE WorkingHistoryPkID=@WorkingHistoryPkID
END
GO
