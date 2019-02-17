
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphtl_MiniBarTypeInfo_DEL')
DROP PROC sphtl_MiniBarTypeInfo_DEL
GO
CREATE PROC sphtl_MiniBarTypeInfo_DEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 

BEGIN
	DECLARE @idoc			INT,
	@id nvarchar(16)
							
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (	id nvarchar(16) )
	EXEC sp_xml_removedocument @idoc

	SELECT 
	@id = id
	FROM #tmp

	BEGIN TRANSACTION

		DELETE FROM htlMiniBarTypeInfo WHERE MiniBarTypeInfoPkID = @id

	COMMIT TRANSACTION
END
GO

