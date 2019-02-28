
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphtl_ServiceInfo_UPD')
DROP PROC sphtl_ServiceInfo_UPD
GO
CREATE PROC sphtl_ServiceInfo_UPD
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
	@description nvarchar(255),
	@ischange nvarchar(1)
							
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (	type int,
				id nvarchar(16),
				name nvarchar(255),
				description nvarchar(255),
				ischange nvarchar(1))
	EXEC sp_xml_removedocument @idoc

	SELECT 
	@type = type,
	@id = id,
	@name = name,
	@description = description,
	@ischange = ischange
	FROM #tmp

	BEGIN TRANSACTION

	IF @type = 1			-- new record
	BEGIN
		
		EXEC dbo.spsmm_LastSequence_SEL 'htlServiceInfo', @id OUTPUT
		INSERT INTO htlServiceInfo VALUES (@id, @name, @description, @ischange)

	END
	ELSE IF @type = 0		-- update record
	BEGIN
		
		UPDATE htlServiceInfo SET 
		ServiceName = @name,
		ServiceDescr = @description,
		IsChangePrice = @ischange
		WHERE ServiceInfoPkID = @id

	END

	COMMIT TRANSACTION
END
GO

