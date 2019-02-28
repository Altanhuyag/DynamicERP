IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_ExperienceInfo_UPD')
DROP PROC sphrm_ExperienceInfo_UPD
GO
CREATE PROC sphrm_ExperienceInfo_UPD
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
			@ExperienceInfoPkID	nvarchar(16),
			@ExperienceInfoName	nvarchar(150)				
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (  Adding				TinyInt,
			ExperienceInfoPkID			nvarchar(16),
			ExperienceInfoName			nvarchar(150))
	EXEC sp_xml_removedocument @idoc 
	
	SELECT	@Adding=Adding,
			@ExperienceInfoPkID=ExperienceInfoPkID,
			@ExperienceInfoName=ExperienceInfoName
	FROM #tmp   
	
	IF @Adding=0 BEGIN

		EXEC spsmm_LastSequence_SEL 'hrmExperienceInfo', @ExperienceInfoPkID output

		INSERT INTO hrmExperienceInfo(
			ExperienceInfoPkID,
			ExperienceInfoName)
		VALUES (@ExperienceInfoPkID,
			@ExperienceInfoName)
	END
	ELSE
		UPDATE hrmExperienceInfo
		SET 
			ExperienceInfoPkID=@ExperienceInfoPkID,
			ExperienceInfoName=@ExperienceInfoName

		WHERE ExperienceInfoPkID=@ExperienceInfoPkID
END
GO
