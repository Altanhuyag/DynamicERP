
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spres_RestaurantInfoGET_SEL')
DROP PROC spres_RestaurantInfoGET_SEL
GO
CREATE PROC spres_RestaurantInfoGET_SEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc				Int,			
			@id					nvarchar(16)
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (  
				id	nvarchar(16)
			 )
	EXEC sp_xml_removedocument @idoc 	
	
	SELECT	@id=id
	FROM #tmp

	select RestaurantPkID, RestaurantName, LogoFile, HeaderText, FooterText, Tax, CityTax, ServiceChargeTax, IsTaxIncluded from resRestaurantInfo where RestaurantPkID = @id

END
GO
