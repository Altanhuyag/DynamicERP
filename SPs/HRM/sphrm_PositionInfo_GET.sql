IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_PositionInfo_GET')
DROP PROC sphrm_PositionInfo_GET
GO
CREATE PROC sphrm_PositionInfo_GET
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 
  
BEGIN
	SET NOCOUNT ON
	DECLARE @idoc			INT,
			@PositionGroupPkID 	nvarchar(50)
	
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (  PositionGroupPkID		nvarchar(50))
	
	EXEC sp_xml_removedocument @idoc
	
	SELECT @PositionGroupPkID=PositionGroupPkID FROM #tmp 
	
	SELECT * FROM hrmPositionInfo
	WHERE PositionGroupPkID=@PositionGroupPkID
END

GO
