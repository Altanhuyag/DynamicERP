
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spres_RestaurantInfo_UPD')
DROP PROC spres_RestaurantInfo_UPD
GO
CREATE PROC spres_RestaurantInfo_UPD
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
	@name nvarchar(75),
	@header nvarchar(255),
	@footer nvarchar(255),
	@tax decimal(18,0),
	@citytax decimal(18,0),
	@servicecharge decimal(18,0)
							
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (	type int,
				id nvarchar(16),
				name nvarchar(75),
				header nvarchar(255),
				footer nvarchar(255),
				tax decimal(18,0),
				citytax decimal(18,0),
				servicecharge decimal(18,0) )
	EXEC sp_xml_removedocument @idoc

	SELECT 
	@type = type,
	@id = id,
	@name = name,
	@header = header,
	@footer = footer,
	@tax = tax,
	@citytax = citytax,
	@servicecharge = servicecharge
	FROM #tmp

	BEGIN TRANSACTION

	IF @type = 1			-- new record
	BEGIN
		

			EXEC dbo.spsmm_LastSequence_SEL 'resRestaurantInfo', @id OUTPUT
			INSERT INTO resRestaurantInfo VALUES (@id, @name, N'', @header, @footer, @tax, @citytax, @servicecharge)

		
	END
	ELSE IF @type = 0		-- update record
	BEGIN
		
		
			UPDATE resRestaurantInfo SET 
			RestaurantName = @name,
			HeaderText = @header,
			FooterText = @footer,
			Tax = @tax,
			CityTax = @citytax,
			ServiceChargeTax = @servicecharge
			WHERE RestaurantPkID = @id

		
	END

	COMMIT TRANSACTION

	SELECT @id as RestaurantPkID
END
GO

