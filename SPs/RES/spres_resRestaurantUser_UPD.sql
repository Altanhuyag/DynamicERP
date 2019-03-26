
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spres_resRestaurantUser_UPD')
DROP PROC spres_resRestaurantUser_UPD
GO
CREATE PROC spres_resRestaurantUser_UPD
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc						int,			
			@RestaurantPkID				nvarchar(16),
			@UserPkID					nvarchar(max)
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (  
				RestaurantPkID			nvarchar(16),
				UserPkID				nvarchar(max)
			 )
	EXEC sp_xml_removedocument @idoc 	
	
	SELECT	@RestaurantPkID=RestaurantPkID, @UserPkID=UserPkID
	FROM #tmp
		
    DELETE FROM resRestaurantUser WHERE RestaurantPkID = @RestaurantPkID

	IF(@UserPkID <> N'')
	BEGIN
		DECLARE @usrid VARCHAR(16)

		DECLARE db_cursor CURSOR FOR 
		SELECT Name FROM splitstringbyseparator(@UserPkID, ',')
		
		OPEN db_cursor  
		FETCH NEXT FROM db_cursor INTO @usrid  

		WHILE @@FETCH_STATUS = 0  
		BEGIN  
			  INSERT INTO resRestaurantUser VALUES (@RestaurantPkID, @usrid)

			  FETCH NEXT FROM db_cursor INTO @usrid 
		END 

		CLOSE db_cursor  
		DEALLOCATE db_cursor 
	END

END
GO
