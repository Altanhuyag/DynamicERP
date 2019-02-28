
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphtl_LifeTimeInfo_UPD')
DROP PROC sphtl_LifeTimeInfo_UPD
GO
CREATE PROC sphtl_LifeTimeInfo_UPD
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
	@dayst int,
	@dayfn int,
	@timest int,
	@timefn int
							
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (	type int,
				id nvarchar(16),
				name nvarchar(255),
				dayst int,
				dayfn int,
				timest int,
				timefn int )
	EXEC sp_xml_removedocument @idoc

	SELECT 
	@type = type,
	@id = id,
	@name = name,
	@dayst = dayst,
	@dayfn = dayfn,
	@timest = timest,
	@timefn = timefn
	FROM #tmp

	BEGIN TRANSACTION

	IF @type = 1			-- new record
	BEGIN
		
		EXEC dbo.spsmm_LastSequence_SEL 'htlLifeTime', @id OUTPUT
		INSERT INTO htlLifeTime VALUES (@id, @name, @dayst, @dayfn, @timest, @timefn)

	END
	ELSE IF @type = 0		-- update record
	BEGIN
		
		UPDATE htlLifeTime SET 
		LifeTimeName = @name,
		StartDay = @dayst,
		FinishDay = @dayfn,
		StartTime = @timest,
		FinishTime = @timefn
		WHERE LifeTimePkID = @id

	END

	COMMIT TRANSACTION
END
GO

