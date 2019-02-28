IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_LearningInfo_UPD')
DROP PROC sphrm_LearningInfo_UPD
GO
CREATE PROC sphrm_LearningInfo_UPD
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
			@LearningTypePkID	nvarchar(16),
			@LearningTypeName	nvarchar(250)
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (  Adding				TinyInt,
			LearningTypePkID	nvarchar(16),
			LearningTypeName	nvarchar(250)
			)
	EXEC sp_xml_removedocument @idoc 
	
	SELECT	@Adding=Adding,
			@LearningTypePkID	= LearningTypePkID,
			@LearningTypeName	= LearningTypeName
	FROM #tmp   
	
	IF @Adding=0 BEGIN

		EXEC spsmm_LastSequence_SEL 'hrmLearningInfo', @LearningTypePkID output

		INSERT INTO hrmLearningInfo(
			LearningTypePkID,
			LearningTypeName
			)
		VALUES (
			@LearningTypePkID,
			@LearningTypeName)
	END
	ELSE
		UPDATE hrmLearningInfo
		SET 
			LearningTypePkID=@LearningTypePkID,
			LearningTypeName=@LearningTypeName

		WHERE LearningTypePkID=@LearningTypePkID
END
GO
