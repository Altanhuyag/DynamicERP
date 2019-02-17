
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

select RestaurantPkID, RestaurantName, LogoFile, HeaderText, FooterText, Tax, CityTax, ServiceChargeTax from resRestaurantInfo

END
GO
