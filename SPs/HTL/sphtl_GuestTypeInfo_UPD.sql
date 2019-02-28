
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphtl_GuestTypeInfo_UPD')
DROP PROC sphtl_GuestTypeInfo_UPD
GO
CREATE PROC sphtl_GuestTypeInfo_UPD
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
	@name nvarchar(255),
	@currencyid nvarchar(6)
							
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (	type int,
				id nvarchar(16),
				name nvarchar(255),
				currencyid nvarchar(6))
	EXEC sp_xml_removedocument @idoc

	SELECT 
	@type = type,
	@id = id,
	@name = name,
	@currencyid = currencyid
	FROM #tmp

	BEGIN TRANSACTION

	IF @type = 1			-- new record
	BEGIN
		
		EXEC dbo.spsmm_LastSequence_SEL 'htlGuestTypeInfo', @id OUTPUT
		INSERT INTO htlGuestTypeInfo VALUES (@id, @name, @currencyid)

	END
	ELSE IF @type = 0		-- update record
	BEGIN
		
		UPDATE htlGuestTypeInfo SET 
		GuestTypeName = @name,
		CurrencyID = @currencyid
		WHERE GuestTypeID = @id

	END

	COMMIT TRANSACTION
END
GO

