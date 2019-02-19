IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_SumInfo_DEL')
DROP PROC sphrm_SumInfo_DEL
GO
CREATE PROC sphrm_SumInfo_DEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc			INT,
			@SumID		nvarchar(20)
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (	SumID		nvarchar(20))
	EXEC sp_xml_removedocument @idoc

	SELECT @SumID=SumID FROM #tmp
	
	DELETE FROM hrmSumInfo
	where SumID = @SumID
	
	END
GO
