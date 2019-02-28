IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_Award_DEL')
DROP PROC sphrm_Award_DEL
GO
CREATE PROC sphrm_Award_DEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc			INT,
			@AwardPkID		nvarchar(16)
			
			
			
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (	AwardPkID		nvarchar(16))
	EXEC sp_xml_removedocument @idoc

	SELECT @AwardPkID=AwardPkID FROM #tmp
	
	DELETE FROM hrmAward
	where AwardPkID = @AwardPkID
	
	END
GO
