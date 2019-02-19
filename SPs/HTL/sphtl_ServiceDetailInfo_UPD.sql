
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphtl_ServiceDetailInfo_UPD')
DROP PROC sphtl_ServiceDetailInfo_UPD
GO
CREATE PROC sphtl_ServiceDetailInfo_UPD
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
	@service nvarchar(16),
	@guest nvarchar(16),
	@currency nvarchar(6),
	@price money
								
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (	type int,
				id nvarchar(16),
				service nvarchar(16),
				guest nvarchar(16),
				currency nvarchar(6),
				price money )
	EXEC sp_xml_removedocument @idoc

	SELECT 
	@type = type,
	@id = id,
	@service = service,
	@guest = guest,
	@currency = currency,
	@price = price
	FROM #tmp

	BEGIN TRANSACTION

	IF @type = 1			-- new record
	BEGIN
		
		EXEC dbo.spsmm_LastSequence_SEL 'htlServiceDetailInfo', @id OUTPUT
		INSERT INTO htlServiceDetailInfo VALUES (@service, @id, @guest, @currency, @price)

	END
	ELSE IF @type = 0		-- update record
	BEGIN
		
		UPDATE htlServiceDetailInfo SET 
		ServiceInfoPkID = @service,
		GuestTypeID = @guest,
		CurrencyID = @currency,
		ServicePrice = @price
		WHERE ServiceDetailInfoPkID = @id

	END

	COMMIT TRANSACTION
END
GO

