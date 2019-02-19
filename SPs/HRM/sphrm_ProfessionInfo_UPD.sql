IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_ProfessionInfo_UPD')
DROP PROC sphrm_ProfessionInfo_UPD
GO
CREATE PROC sphrm_ProfessionInfo_UPD
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
			@ProfessionPkID  NVARCHAR(16),
			@ProfessionName  NVARCHAR(255)
	
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (  Adding				TinyInt,
				ProfessionPkID		NVARCHAR(16),
				ProfessionName		NVARCHAR(255))
	EXEC sp_xml_removedocument @idoc 	

	
	SELECT @Adding=Adding, @ProfessionPkID=ProfessionPkID, @ProfessionName=ProfessionName FROM #tmp
   
	
	IF @Adding=0 BEGIN 
	
		IF (SELECT COUNT(*) FROM hrmProfessionInfo WHERE ProfessionName=@ProfessionName) > 0
			BEGIN
 				RAISERROR ('Мэргэжлийн нэр давхардаж байна !', 16, 1)
				RETURN (1)		
			END
		
		EXEC spsmm_LastSequence_SEL 'hrmProfessionInfo', @ProfessionPkID output

		INSERT INTO hrmProfessionInfo(ProfessionPkID, ProfessionName)		
		VALUES (@ProfessionPkID, @ProfessionName) 
	END
	ELSE
		UPDATE hrmProfessionInfo
		SET ProfessionName=@ProfessionName
		WHERE ProfessionPkID=@ProfessionPkID 
END


GO
