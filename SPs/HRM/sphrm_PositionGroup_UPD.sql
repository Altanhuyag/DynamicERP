IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_PositionGroup_UPD')
DROP PROC sphrm_PositionGroup_UPD
GO
CREATE PROC sphrm_PositionGroup_UPD
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
			@PositionGroupPkID  NVARCHAR(16),
			@PositionGroupName  NVARCHAR(255)
	
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (  Adding				TinyInt,
				PositionGroupPkID		NVARCHAR(16),
				PositionGroupName		NVARCHAR(255))
	EXEC sp_xml_removedocument @idoc 	

	
	SELECT @Adding=Adding, @PositionGroupPkID=PositionGroupPkID, @PositionGroupName=PositionGroupName FROM #tmp
   
	
	IF @Adding=0 BEGIN 
	
		IF (SELECT COUNT(*) FROM hrmPositionGroup WHERE PositionGroupName=@PositionGroupName) > 0
			BEGIN
 				RAISERROR ('Албан тушаалын ангилалын нэр давхардаж байна !', 16, 1)
				RETURN (1)		
			END
		
		EXEC dbo.spsmm_LastSequence_SEL 'hrmPositionGroup', @PositionGroupPkID output

		INSERT INTO hrmPositionGroup(PositionGroupPkID, PositionGroupName)		
		VALUES (@PositionGroupPkID,@PositionGroupName) 
	END
	ELSE
		UPDATE hrmPositionGroup
		SET PositionGroupName=@PositionGroupName
		WHERE PositionGroupPkID=@PositionGroupPkID 
END



GO
