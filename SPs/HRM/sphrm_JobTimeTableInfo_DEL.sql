IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_JobTimeTableInfo_DEL')
DROP PROC sphrm_JobTimeTableInfo_DEL
GO
CREATE PROC sphrm_JobTimeTableInfo_DEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc			INT,
			@JobTimeTableInfoPkID nvarchar(16)
			
			
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (	JobTimeTableInfoPkID		nvarchar(16) )
	EXEC sp_xml_removedocument @idoc

	select @JobTimeTableInfoPkID=JobTimeTableInfoPkID from #tmp

  	DELETE 
	FROM hrmJobTimeTableInfo where JobTimeTableInfoPkID=@JobTimeTableInfoPkID
END
GO
