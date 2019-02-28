
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
	@name nvarchar(150)
							
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (	name nvarchar(150) )
	EXEC sp_xml_removedocument @idoc

	SELECT 
	@name = name
	FROM #tmp

	SELECT a.ServiceDetailInfoPkID, b.ServiceName, c.GuestTypeName, d.CurrencyName, a.ServicePrice
	FROM htlServiceDetailInfo a
	INNER JOIN htlServiceInfo b ON b.ServiceInfoPkID = a.ServiceInfoPkID
	INNER JOIN htlGuestTypeInfo c ON c.GuestTypeID = a.GuestTypeID
	INNER JOIN accCurrencyInfo d ON d.CurrencyID = a.CurrencyID 
	WHERE b.ServiceName like N'%' + @name + '%'

END
GO