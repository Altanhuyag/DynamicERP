
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphtl_RoomInfo_UPD')
DROP PROC sphtl_RoomInfo_UPD
GO
CREATE PROC sphtl_RoomInfo_UPD
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
	@GroupPkID nvarchar(16),
	@RoomTypePkID nvarchar(16),
	@RoomBedSpace int,
	@RoomNumber int,
	@RoomFloor int,
	@RoomPhone nvarchar(50),
	@RoomDescr nvarchar(255),
	@IsMiniBar nvarchar(1),
	@MiniBarTypeInfoPkID nvarchar(16),
	@FactionInfoPkID nvarchar(16),
	@GuestSpace int
							
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (	type int,
				id nvarchar(16),
				GroupPkID nvarchar(16),
				RoomTypePkID nvarchar(16),
				RoomBedSpace int,
				RoomNumber int,
				RoomFloor int,
				RoomPhone nvarchar(50),
				RoomDescr nvarchar(255),
				IsMiniBar nvarchar(1),
				MiniBarTypeInfoPkID nvarchar(16),
				FactionInfoPkID nvarchar(16),
				GuestSpace int )
	EXEC sp_xml_removedocument @idoc

	SELECT 
	@type = type,
	@id = id,
	@GroupPkID = GroupPkID,
	@RoomTypePkID = RoomTypePkID,
	@RoomBedSpace = RoomBedSpace,
	@RoomNumber = RoomNumber,
	@RoomFloor = RoomFloor,
	@RoomPhone = RoomPhone,
	@RoomDescr = RoomDescr,
	@IsMiniBar = IsMiniBar,
	@MiniBarTypeInfoPkID = MiniBarTypeInfoPkID,
	@FactionInfoPkID = FactionInfoPkID,
	@GuestSpace = GuestSpace
	FROM #tmp

	BEGIN TRANSACTION

	IF @type = 1			-- new record
	BEGIN
		
		EXEC dbo.spsmm_LastSequence_SEL 'htlRoomInfo', @id OUTPUT
		INSERT INTO htlRoomInfo VALUES (@id, @GroupPkID, @RoomTypePkID, @RoomBedSpace, @RoomNumber, 
		@RoomFloor, @RoomPhone, @RoomDescr, @IsMiniBar, @MiniBarTypeInfoPkID, @FactionInfoPkID, @GuestSpace)

	END
	ELSE IF @type = 0		-- update record
	BEGIN
		
		UPDATE htlRoomInfo SET 
		GroupPkID = @GroupPkID,
		RoomTypePkID = @RoomTypePkID,
		RoomBedSpace = @RoomBedSpace,
		RoomNumber = @RoomNumber,
		RoomFloor = @RoomFloor,
		RoomPhone = @RoomPhone,
		RoomDescr = @RoomDescr,
		IsMiniBar = @IsMiniBar,
		MiniBarTypeInfoPkID = @MiniBarTypeInfoPkID,
		FactionInfoPkID = @FactionInfoPkID,
		GuestSpace = @GuestSpace
		WHERE RoomPkID = @id

	END

	COMMIT TRANSACTION
END
GO

