
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spres_resRestaurantTableGET_SEL')
DROP PROC spres_resRestaurantTableGET_SEL
GO
CREATE PROC spres_resRestaurantTableGET_SEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc						Int,			
			@CategoryPkID				nvarchar(16)
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (  
				CategoryPkID	nvarchar(16)
			 )
	EXEC sp_xml_removedocument @idoc 	
	
	SELECT	@CategoryPkID=CategoryPkID
	FROM #tmp
		
	SELECT TablePkID, TableID, TableCapacity, IsTime FROM resRestaurantTable WHERE CategoryPkID = @CategoryPkID

END
GO
