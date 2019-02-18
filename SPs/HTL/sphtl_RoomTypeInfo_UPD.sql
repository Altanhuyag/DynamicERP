
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphtl_RoomTypeInfo_UPD')
DROP PROC sphtl_RoomTypeInfo_UPD
GO
CREATE PROC sphtl_RoomTypeInfo_UPD
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 

BEGIN
	DECLARE @idoc			INT,
	@type int,
	@id nvarchar(16),
	@name nvarchar(75)
							
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (	type int,
				id nvarchar(16),
				name nvarchar(75) )
	EXEC sp_xml_removedocument @idoc

	SELECT 
	@type = type,
	@id = id,
	@name = name
	FROM #tmp

	BEGIN TRANSACTION

	IF @type = 1			-- new record
	BEGIN
		
		EXEC dbo.spsmm_LastSequence_SEL 'htlRoomTypeInfo', @id OUTPUT
		INSERT INTO htlRoomTypeInfo VALUES (@id, @name)

	END
	ELSE IF @type = 0		-- update record
	BEGIN
		
		UPDATE htlRoomTypeInfo SET 
		TypeName = @name
		WHERE RoomTypePkID = @id

	END

	COMMIT TRANSACTION
END
GO

