
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spres_resOrderItemsGET_SEL')
DROP PROC spres_resOrderItemsGET_SEL
GO
CREATE PROC spres_resOrderItemsGET_SEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc						Int,			
			@OrderPkID				nvarchar(16)
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (  
				OrderPkID	nvarchar(16)
			 )
	EXEC sp_xml_removedocument @idoc 	
	
	SELECT	@OrderPkID = OrderPkID
	FROM #tmp
	
	SELECT a.OrderPkID, a.ItemPkID, b.ItemName, a.Price, a.Qty, c.BufetInfoName FROM resOrderItems a
	INNER JOIN resItemInfo b on b.ItemPkID = a.ItemPkID
	INNER JOIN resItemBuffetInfo c on c.BufetInfoPkID = b.BufetInfoPkID
	WHERE a.OrderPkID = @OrderPkID

END
GO
