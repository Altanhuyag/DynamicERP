IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_ExtraRequirement_UPD')
DROP PROC sphrm_ExtraRequirement_UPD
GO
CREATE PROC sphrm_ExtraRequirement_UPD
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
			@ExtraRequirementPkID	nvarchar(16),
			@ExtraRequirementName	nvarchar(150)				
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (  Adding				TinyInt,
			ExtraRequirementPkID			nvarchar(16),
			ExtraRequirementName			nvarchar(150))
	EXEC sp_xml_removedocument @idoc 
	
	SELECT	@Adding=Adding,
			@ExtraRequirementPkID=ExtraRequirementPkID,
			@ExtraRequirementName=ExtraRequirementName
	FROM #tmp   
	
	IF @Adding=0 BEGIN

		EXEC spsmm_LastSequence_SEL 'hrmExtraRequirement', @ExtraRequirementPkID output

		INSERT INTO hrmExtraRequirement(
			ExtraRequirementPkID,
			ExtraRequirementName)
		VALUES (@ExtraRequirementPkID,
			@ExtraRequirementName)
	END
	ELSE
		UPDATE hrmExtraRequirement
		SET 
			ExtraRequirementPkID=@ExtraRequirementPkID,
			ExtraRequirementName=@ExtraRequirementName

		WHERE ExtraRequirementPkID=@ExtraRequirementPkID
END
GO
