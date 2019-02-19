IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_ExperienceInfo_DEL')
DROP PROC sphrm_ExperienceInfo_DEL
GO
CREATE PROC sphrm_ExperienceInfo_DEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc			INT,
			@ExperienceInfoPkID		nvarchar(16)
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (	ExperienceInfoPkID		nvarchar(16))
	EXEC sp_xml_removedocument @idoc

	SELECT @ExperienceInfoPkID=ExperienceInfoPkID FROM #tmp
	
	DELETE FROM hrmExperienceInfo
	where ExperienceInfoPkID = @ExperienceInfoPkID
	
	END
GO
