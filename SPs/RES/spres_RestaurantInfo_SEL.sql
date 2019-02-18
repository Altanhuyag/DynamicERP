
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spres_RestaurantInfo_SEL')
DROP PROC spres_RestaurantInfo_SEL
GO
CREATE PROC spres_RestaurantInfo_SEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc				Int,			
			@name					nvarchar(75)
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (  
				name	nvarchar(75)
			 )
	EXEC sp_xml_removedocument @idoc 	
	
	SELECT	@name=name
	FROM #tmp

	select RestaurantPkID, RestaurantName, LogoFile, HeaderText, FooterText, Tax, CityTax, ServiceChargeTax from resRestaurantInfo where RestaurantName like N'%' + @name + '%'

END
GO
