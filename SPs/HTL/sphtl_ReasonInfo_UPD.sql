
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphtl_ReasonInfo_UPD')
DROP PROC sphtl_ReasonInfo_UPD
GO
CREATE PROC sphtl_ReasonInfo_UPD
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
	@start int,
	@finish int,
	@mstr int
							
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (	type int,
				id nvarchar(16),
				name nvarchar(75),
				start int,
				finish int,
				mstr int )
	EXEC sp_xml_removedocument @idoc

	SELECT 
	@type = type,
	@id = id,
	@name = name,
	@start = start,
	@finish = finish,
	@mstr = mstr
	FROM #tmp

	BEGIN TRANSACTION

	IF @type = 1			-- new record
	BEGIN
		
		EXEC dbo.spsmm_LastSequence_SEL 'htlReasonInfo', @id OUTPUT
		INSERT INTO htlReasonInfo VALUES (@id, @name, @start, @finish, @mstr)

	END
	ELSE IF @type = 0		-- update record
	BEGIN
		
		UPDATE htlReasonInfo SET 
		ReasonName = @name,
		StartMonth = @start,
		FinishMonth = @finish,
		MonthStr = @mstr
		WHERE ReasonInfoPkID = @id

	END

	COMMIT TRANSACTION
END
GO

