
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spres_resRestaurantCategoryGET_SEL')
DROP PROC spres_resRestaurantCategoryGET_SEL
GO
CREATE PROC spres_resRestaurantCategoryGET_SEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc						Int,			
			@RestaurantPkID				nvarchar(16)
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (  
				RestaurantPkID	nvarchar(16)
			 )
	EXEC sp_xml_removedocument @idoc 	
	
	SELECT	@RestaurantPkID=RestaurantPkID
	FROM #tmp
		
	SELECT CategoryPkID, CategoryName FROM resRestaurantCategory WHERE RestaurantPkID = @RestaurantPkID

END
GO
