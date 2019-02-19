IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_JobFugureInfo_DEL')
DROP PROC sphrm_JobFugureInfo_DEL
GO
CREATE PROC sphrm_JobFugureInfo_DEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc			INT,
			@JobFugureInfoPkID nvarchar(16)
			
			
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (	JobFugureInfoPkID		nvarchar(16) )
	EXEC sp_xml_removedocument @idoc

	select @JobFugureInfoPkID=JobFugureInfoPkID from #tmp

  	DELETE FROM hrmJobFugureInfo 
	where JobFugureInfoPkID=@JobFugureInfoPkID
END
GO
