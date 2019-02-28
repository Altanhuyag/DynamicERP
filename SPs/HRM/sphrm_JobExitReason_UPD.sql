IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_JobExitReason_UPD')
DROP PROC sphrm_JobExitReason_UPD
GO
CREATE PROC sphrm_JobExitReason_UPD
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc				Int,
			@Adding				TinyInt,
			@JobExitReasonPkID nvarchar(16),
			@JobExitReasonName nvarchar(255)
			
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (  Adding		  TinyInt,
			JobExitReasonPkID nvarchar(16),
			JobExitReasonName nvarchar(255)
			)
	EXEC sp_xml_removedocument @idoc 	

	
	SELECT	@Adding=Adding,
			@JobExitReasonPkID=JobExitReasonPkID,
			@JobExitReasonName=JobExitReasonName
	FROM #tmp

	IF @Adding=0 BEGIN

		EXEC spsmm_LastSequence_SEL 'hrmJobExitReason', @JobExitReasonPkID output

		INSERT INTO hrmJobExitReason(JobExitReasonPkID ,JobExitReasonName)
		VALUES (@JobExitReasonPkID,@JobExitReasonName)	
	END
	ELSE
		UPDATE hrmJobExitReason
		SET JobExitReasonPkID=@JobExitReasonPkID,
			JobExitReasonName=@JobExitReasonName
			
		WHERE JobExitReasonPkID=@JobExitReasonPkID
END
GO
