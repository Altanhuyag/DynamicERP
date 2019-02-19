IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_JobExitReason_DEL')
DROP PROC sphrm_JobExitReason_DEL
GO
CREATE PROC sphrm_JobExitReason_DEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc			INT,
			@JobExitReasonPkID		nvarchar(16)
		
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (	JobExitReasonPkID		nvarchar(16))
	EXEC sp_xml_removedocument @idoc
	SELECT @JobExitReasonPkID=JobExitReasonPkID FROM #tmp
	DELETE FROM hrmJobExitReason
	where JobExitReasonPkID = @JobExitReasonPkID
	
	END
GO
