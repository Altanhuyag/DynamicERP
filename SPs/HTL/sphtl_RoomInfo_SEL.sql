
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphtl_RoomInfo_SEL')
DROP PROC sphtl_RoomInfo_SEL
GO
CREATE PROC sphtl_RoomInfo_SEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 

BEGIN

	DECLARE @idoc			INT,
	@number nvarchar(150)
							
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (	number nvarchar(150) )
	EXEC sp_xml_removedocument @idoc

	SELECT 
	@number = number
	FROM #tmp

	SELECT RoomPkID, b.GroupName, c.TypeName, RoomBedSpace, RoomNumber, RoomFloor, RoomPhone, RoomDescr, 
	(case when IsMiniBar = N'T' then N'Тийм' else N'Үгүй' end) as IsMiniBar, d.MiniBarTypeName, e.FactionName, GuestSpace 
	FROM htlRoomInfo a
	INNER JOIN htlRoomGroupInfo b ON b.GroupPkID = a.GroupPkID
	INNER JOIN htlRoomTypeInfo c ON c.RoomTypePkID = a.RoomTypePkID
	LEFT JOIN htlMiniBarTypeInfo d ON d.MiniBarTypeInfoPkID = a.MiniBarTypeInfoPkID
	INNER JOIN htlFactionInfo e on e.FactionInfoPkID = a.FactionInfoPkID
	WHERE RoomNumber like N'' + @number + '%'

END
GO
