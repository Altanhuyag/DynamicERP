IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_FreedomTypeInfo_UPD')
DROP PROC sphrm_FreedomTypeInfo_UPD
GO
CREATE PROC sphrm_FreedomTypeInfo_UPD
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
			@FreedomTypePkID	nvarchar(16),
			@FreedomTypeName	nvarchar(255)				
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (  Adding				TinyInt,
			FreedomTypePkID			nvarchar(16),
			FreedomTypeName			nvarchar(255))
	EXEC sp_xml_removedocument @idoc 
	
	SELECT	@Adding=Adding,
			@FreedomTypePkID=FreedomTypePkID,
			@FreedomTypeName=FreedomTypeName
	FROM #tmp   
	
	IF @Adding=0 BEGIN

		EXEC spsmm_LastSequence_SEL 'hrmFreedomTypeInfo', @FreedomTypePkID output

		INSERT INTO hrmFreedomTypeInfo(
			FreedomTypePkID,
			FreedomTypeName)
		VALUES (@FreedomTypePkID,
			@FreedomTypeName)
	END
	ELSE
		UPDATE hrmFreedomTypeInfo
		SET 
			FreedomTypePkID=@FreedomTypePkID,
			FreedomTypeName=@FreedomTypeName

		WHERE FreedomTypePkID=@FreedomTypePkID
END
GO
