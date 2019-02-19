IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_DeduceInfo_UPD')
DROP PROC sphrm_DeduceInfo_UPD
GO
CREATE PROC sphrm_DeduceInfo_UPD
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
			@DeduceInfoPkID		NVARCHAR(16),
			@DeduceInfoName		NVARCHAR(255)
	
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (  Adding					TinyInt,
				DeduceInfoPkID			NVARCHAR(16),
				DeduceInfoName			NVARCHAR(255))
	EXEC sp_xml_removedocument @idoc 	

	
	SELECT @Adding=Adding, @DeduceInfoPkID=DeduceInfoPkID, @DeduceInfoName=DeduceInfoName FROM #tmp
   
	
	IF @Adding=0 BEGIN
	
		IF (SELECT COUNT(*) FROM hrmDeduceInfo WHERE @DeduceInfoName=DeduceInfoName) > 0
			BEGIN
 				RAISERROR ('Нийгмийн гарлын нэр давхардаж байна !', 16, 1)
				RETURN (1)
			END
		
		EXEC dbo.spsmm_LastSequence_SEL 'hrmDeduceInfo', @DeduceInfoPkID output

		INSERT INTO hrmDeduceInfo(DeduceInfoPkID, DeduceInfoName )		
		VALUES (@DeduceInfoPkID, @DeduceInfoName ) 
	END
	ELSE
		UPDATE hrmDeduceInfo
		SET DeduceInfoName=@DeduceInfoName
		WHERE DeduceInfoPkID=@DeduceInfoPkID
END
GO
