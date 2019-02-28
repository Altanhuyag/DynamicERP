IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_AimagInfo_UPD')
DROP PROC sphrm_AimagInfo_UPD
GO
CREATE PROC sphrm_AimagInfo_UPD
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc				Int,
			@Adding				int,
			@AimagID			NVARCHAR(20),
			@AimagName			nvarchar(250)
	
	
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (	
				Adding				Int,
				AimagID				NVARCHAR(20),
				AimagName			nvarchar(250))

	EXEC sp_xml_removedocument @idoc 	
	
	SELECT	@Adding=Adding, @AimagID=AimagID, @AimagName=AimagName 	FROM #tmp	
	
	IF @Adding=0 BEGIN

		IF (SELECT count(*) FROM hrmAimagInfo WHERE AimagID=@AimagID) > 0 BEGIN
			RAISERROR('Аймагийн код давхардаж байна.',16,1)
			RETURN 1
		END

		INSERT INTO hrmAimagInfo(AimagID, AimagName, SortNo)
		VALUES (@AimagID, @AimagName, 1)
	END
	ELSE 
	BEGIN
		UPDATE	hrmAimagInfo
        SET		AimagName=@AimagName
		WHERE AimagID=@AimagID
		
	END

END
GO
