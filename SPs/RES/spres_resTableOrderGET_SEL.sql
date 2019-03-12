
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spres_resTableOrderGET_SEL')
DROP PROC spres_resTableOrderGET_SEL
GO
CREATE PROC spres_resTableOrderGET_SEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc						Int,			
			@TablePkID				nvarchar(16)
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (  
				TablePkID	nvarchar(16)
			 )
	EXEC sp_xml_removedocument @idoc 	
	
	SELECT	@TablePkID = TablePkID
	FROM #tmp
		
	SELECT OrderPkID, OrderDate, Status, PosDate FROM resOrderInfo WHERE TablePkID = @TablePkID AND Status = 0
	
END
GO
