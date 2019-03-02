
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spres_resItemInfoGET_SEL')
DROP PROC spres_resItemInfoGET_SEL
GO
CREATE PROC spres_resItemInfoGET_SEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc						Int,			
			@RestaurantMenuPkID				nvarchar(16)
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (  
				RestaurantMenuPkID	nvarchar(16)
			 )
	EXEC sp_xml_removedocument @idoc 	
	
	SELECT	@RestaurantMenuPkID = RestaurantMenuPkID
	FROM #tmp
		
	SELECT ItemPkID, ItemName, OutPrice FROM resItemInfo WHERE RestaurantMenuPkID = @RestaurantMenuPkID

END
GO
