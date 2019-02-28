IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_Family_DEL')
DROP PROC sphrm_Family_DEL
GO
CREATE PROC sphrm_Family_DEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc			INT,
			@FamilyPkID		nvarchar(16)
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (	FamilyPkID		nvarchar(16))
	EXEC sp_xml_removedocument @idoc

	SELECT @FamilyPkID=FamilyPkID FROM #tmp
	
	DELETE FROM hrmFamily
	where FamilyPkID = @FamilyPkID
	
	END
GO
