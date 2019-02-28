IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_LearningInfo_DEL')
DROP PROC sphrm_LearningInfo_DEL
GO
CREATE PROC sphrm_LearningInfo_DEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc			INT,
			@LearningTypePkID		nvarchar(16)
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (	LearningTypePkID		nvarchar(16))
	EXEC sp_xml_removedocument @idoc

	SELECT @LearningTypePkID=LearningTypePkID FROM #tmp
	
	DELETE FROM hrmLearningInfo
	where LearningTypePkID = @LearningTypePkID
	
	END
GO
