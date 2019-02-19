IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_ExpertInfo_UPD')
DROP PROC sphrm_ExpertInfo_UPD
GO
CREATE PROC sphrm_ExpertInfo_UPD
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
			@ExpertInfoPkID		nvarchar(16),
			@ExpertInfoName		nvarchar(150)				
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (  Adding				TinyInt,
			ExpertInfoPkID			nvarchar(16),
			ExpertInfoName			nvarchar(150))
	EXEC sp_xml_removedocument @idoc 
	
	SELECT	@Adding=Adding,
			@ExpertInfoPkID=ExpertInfoPkID,
			@ExpertInfoName=ExpertInfoName
	FROM #tmp   
	
	IF @Adding=0 BEGIN

		EXEC spsmm_LastSequence_SEL 'hrmExpertInfo', @ExpertInfoPkID output

		INSERT INTO hrmExpertInfo(
			ExpertInfoPkID,
			ExpertInfoName)
		VALUES (@ExpertInfoPkID,
			@ExpertInfoName)
	END
	ELSE
		UPDATE hrmExpertInfo
		SET 
			ExpertInfoPkID=@ExpertInfoPkID,
			ExpertInfoName=@ExpertInfoName

		WHERE ExpertInfoPkID=@ExpertInfoPkID
END
GO
