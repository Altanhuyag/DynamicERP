IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_ExtraRequirement_DEL')
DROP PROC sphrm_ExtraRequirement_DEL
GO
CREATE PROC sphrm_ExtraRequirement_DEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc			INT,
			@ExtraRequirementPkID		nvarchar(16)
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (	ExtraRequirementPkID		nvarchar(16))
	EXEC sp_xml_removedocument @idoc

	SELECT @ExtraRequirementPkID=ExtraRequirementPkID FROM #tmp
	
	DELETE FROM hrmExtraRequirement
	where ExtraRequirementPkID = @ExtraRequirementPkID
	
	END
GO
