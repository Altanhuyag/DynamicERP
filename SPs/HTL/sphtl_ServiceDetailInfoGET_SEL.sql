
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphtl_ServiceDetailInfo_SEL')
DROP PROC sphtl_ServiceDetailInfo_SEL
GO
CREATE PROC sphtl_ServiceDetailInfo_SEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 

BEGIN

	DECLARE @idoc			INT,
	@id nvarchar(150)
							
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (	id nvarchar(150) )
	EXEC sp_xml_removedocument @idoc

	SELECT 
	@id = id
	FROM #tmp

	SELECT ServiceInfoPkID, ServiceDetailInfoPkID, GuestTypeID, CurrencyID, ServicePrice FROM htlServiceDetailInfo
	WHERE ServiceDetailInfoPkID = @id

END
GO