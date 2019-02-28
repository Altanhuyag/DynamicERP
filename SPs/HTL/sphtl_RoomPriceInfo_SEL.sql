
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphtl_RoomPriceInfo_SEL')
DROP PROC sphtl_RoomPriceInfo_SEL
GO
CREATE PROC sphtl_RoomPriceInfo_SEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 

BEGIN

	DECLARE @idoc			INT,
	@curid nvarchar(6)
							
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (	curid nvarchar(6) )
	EXEC sp_xml_removedocument @idoc

	SELECT 
	@curid = curid
	FROM #tmp

	SELECT 
    DISTINCT
	ISNULL((SELECT RoomPricePkID FROM htlRoomPrice WHERE RoomTypePkID = t0.RoomTypePkID and SeasonInfoPkID = t1.SeasonInfoPkID and GuestTypeID = t2.GuestTypeID and LifeTimePkID = t3.LifeTimePkID and CurrencyID = t4.CurrencyID), 0) AS RoomPricePkID,
	t0.RoomTypePkID,
	t0.TypeName,
	t1.SeasonInfoPkID,
    t1.SeasonName,
	t2.GuestTypeID,
    t2.GuestTypeName,
	t3.LifeTimePkID,
	t3.LifeTimeName,
	t4.CurrencyID,
	t4.CurrencyName,
	ISNULL((SELECT Price FROM htlRoomPrice WHERE RoomTypePkID = t0.RoomTypePkID and SeasonInfoPkID = t1.SeasonInfoPkID and GuestTypeID = t2.GuestTypeID and LifeTimePkID = t3.LifeTimePkID and CurrencyID = t4.CurrencyID), 0) AS Price
	FROM 
	htlRoomTypeInfo t0,
    htlSeasonInfo t1,
    htlGuestTypeInfo t2,
	htlLifeTime t3,
	accCurrencyInfo t4
	WHERE t4.CurrencyID = @curid
	ORDER BY TypeName, SeasonName, GuestTypeName, LifeTimeName

END
GO