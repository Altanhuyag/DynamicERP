
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spres_resOrderInfo_DEL')
DROP PROC spres_resOrderInfo_DEL
GO
CREATE PROC spres_resOrderInfo_DEL
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

		UPDATE resOrderInfo SET Status = 1 WHERE OrderPkID = @id

	COMMIT TRANSACTION
END
GO

