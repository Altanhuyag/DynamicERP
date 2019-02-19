IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_Year_DEL')
DROP PROC sphrm_Year_DEL
GO
CREATE PROC sphrm_Year_DEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc			INT,
			@YearPkID	nvarchar(16)
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (	YearPkID		nvarchar(16))
	EXEC sp_xml_removedocument @idoc

	SELECT @YearPkID=YearPkID FROM #tmp
	
	DELETE FROM hrmYearInfo
	where YearPkID = @YearPkID
	
	END
GO
