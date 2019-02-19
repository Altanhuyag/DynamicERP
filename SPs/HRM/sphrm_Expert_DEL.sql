IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_Expert_DEL')
DROP PROC sphrm_Expert_DEL
GO
CREATE PROC sphrm_Expert_DEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc			INT,
			@ExpertPkID	nvarchar(16)
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (	ExpertPkID		nvarchar(16))
	EXEC sp_xml_removedocument @idoc

	SELECT @ExpertPkID=ExpertPkID FROM #tmp
	
	DELETE FROM hrmExpert
	where ExpertPkID = @ExpertPkID
	
	END
GO
