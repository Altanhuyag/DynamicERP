
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphtl_RoomGroupInfo_SEL')
DROP PROC sphtl_RoomGroupInfo_SEL
GO
CREATE PROC sphtl_RoomGroupInfo_SEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 

BEGIN

	DECLARE @idoc			INT,
	@name nvarchar(150)
							
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (	name nvarchar(150) )
	EXEC sp_xml_removedocument @idoc

	SELECT 
	@name = name
	FROM #tmp

	SELECT GroupPkID, GroupName FROM htlRoomGroupInfo WHERE GroupName like N'%' + @name + '%'

END
GO
