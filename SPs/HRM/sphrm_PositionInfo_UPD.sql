IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_PositionInfo_UPD')
DROP PROC sphrm_PositionInfo_UPD
GO
CREATE PROC sphrm_PositionInfo_UPD
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS
  
BEGIN
	SET NOCOUNT ON
	DECLARE @idoc				INT,
			@Adding				TinyInt,
			@PositionPkID		NVARCHAR(16),
			@PositionGroupPkID	NVARCHAR(16),
			@PositionName		NVARCHAR(255),
			@SortedOrder			int
	
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (  Adding				TinyInt,
				PositionPkID		NVARCHAR(16),
				PositionGroupPkID	NVARCHAR(16),
				PositionName		NVARCHAR(255),
				SortedOrder				int)
	EXEC sp_xml_removedocument @idoc 	

	
	SELECT	@Adding=Adding, @PositionPkID=PositionPkID, 
			@PositionGroupPkID=PositionGroupPkID, @PositionName=PositionName,@SortedOrder = ISNULL(SortedOrder,0) FROM #tmp
   
	
	IF @Adding=0 BEGIN 
	
		IF (SELECT COUNT(*) FROM hrmPositionInfo WHERE PositionName=@PositionName) > 0
			BEGIN
 				RAISERROR ('Албан тушаалын нэр давхардаж байна !', 16, 1)
				RETURN (1)		
			END
		
		EXEC dbo.spsmm_LastSequence_SEL 'hrmPositionInfo', @PositionPkID output
		
		INSERT INTO hrmPositionInfo(PositionPkID, PositionGroupPkID, PositionName,SortedOrder)
		VALUES (@PositionPkID, @PositionGroupPkID, @PositionName,@SortedOrder) 
	END
	ELSE
		UPDATE hrmPositionInfo
		SET PositionName=@PositionName,
			PositionGroupPkID=@PositionGroupPkID,SortedOrder = @SortedOrder
		WHERE PositionPkID=@PositionPkID
END


GO
