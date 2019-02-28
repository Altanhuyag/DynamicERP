
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphtl_RoomPriceInfo_UPD')
DROP PROC sphtl_RoomPriceInfo_UPD
GO
CREATE PROC sphtl_RoomPriceInfo_UPD
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 

BEGIN
	DECLARE @idoc			INT,
	@passvalue nvarchar(max),
	@type int,
	@id nvarchar(16),
	@RoomTypePkID nvarchar(16),
	@SeasonInfoPkID nvarchar(16),
	@GuestTypeID nvarchar(16),
	@LifeTimePkID nvarchar(16),
	@CurrencyID nvarchar(16),
	@Price money
							
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (	passvalue nvarchar(max)  )
	EXEC sp_xml_removedocument @idoc

	SELECT 
	@passvalue = passvalue
	FROM #tmp

	BEGIN TRANSACTION
	
		DECLARE @name VARCHAR(max)
		DECLARE db_cursor CURSOR FOR 
		SELECT Name FROM splitstringbyseparator(@passvalue, ';')

		OPEN db_cursor  
		FETCH NEXT FROM db_cursor INTO @name  

		WHILE @@FETCH_STATUS = 0  
		BEGIN  
			
			SELECT 
			@type = (SELECT Name FROM splitstringbyseparator(@name, ',') WHERE Number = 0),
			@id = (SELECT Name FROM splitstringbyseparator(@name, ',') WHERE Number = 1),
			@RoomTypePkID = (SELECT Name FROM splitstringbyseparator(@name, ',') WHERE Number = 2),
			@SeasonInfoPkID = (SELECT Name FROM splitstringbyseparator(@name, ',') WHERE Number = 3),
			@GuestTypeID = (SELECT Name FROM splitstringbyseparator(@name, ',') WHERE Number = 4),
			@LifeTimePkID = (SELECT Name FROM splitstringbyseparator(@name, ',') WHERE Number = 5),
			@CurrencyID = (SELECT Name FROM splitstringbyseparator(@name, ',') WHERE Number = 6),
			@Price = (SELECT Name FROM splitstringbyseparator(@name, ',') WHERE Number = 7)

			IF @type = 1			-- new record
			BEGIN
		
			EXEC dbo.spsmm_LastSequence_SEL 'htlRoomPrice', @id OUTPUT
			INSERT INTO htlRoomPrice VALUES (@id, @RoomTypePkID, @SeasonInfoPkID, @GuestTypeID, @LifeTimePkID, @CurrencyID, @Price)

			END
			ELSE IF @type = 0		-- update record
			BEGIN
		
			UPDATE htlRoomPrice SET 
			Price = @Price
			WHERE RoomPricePkID = @id

			END


		FETCH NEXT FROM db_cursor INTO @name 
		END 

		CLOSE db_cursor  
		DEALLOCATE db_cursor


	COMMIT TRANSACTION
END
GO

