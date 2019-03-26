IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spres_RestaurantImage_UPD')
DROP PROC spres_RestaurantImage_UPD
GO
CREATE PROC spres_RestaurantImage_UPD
(
			@XML		  NVARCHAR(MAX),
			@IntResult    TINYINT		 OUTPUT,
			@StrResult    NVARCHAR(2000) OUTPUT	
) WITH ENCRYPTION
AS

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc				Int,			
			@RestaurantPkID		nvarchar(16),
			@ImageFileExt	nvarchar(10)
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (  
				RestaurantPkID	nvarchar(16),
				ImageFileExt		nvarchar(10)
			 )
	EXEC sp_xml_removedocument @idoc 	
	
	SELECT	@RestaurantPkID=RestaurantPkID,			
			@ImageFileExt=ImageFileExt
	FROM #tmp
   	
	UPDATE resRestaurantInfo
	SET LogoFile = N'upload/restaurant/'+@RestaurantPkID + @ImageFileExt
	WHERE RestaurantPkID = @RestaurantPkID
	
		
END
GO