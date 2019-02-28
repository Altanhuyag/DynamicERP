IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_JobTimeTableInfo_UPD')
DROP PROC sphrm_JobTimeTableInfo_UPD
GO
CREATE PROC sphrm_JobTimeTableInfo_UPD
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc						Int,
			@Adding						TinyInt,
			@JobTimeTableInfoPkID		nvarchar(16),
			@JobTimeTableInfoName		nvarchar(150)
			
	
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (  Adding				TinyInt,	
			JobTimeTableInfoPkID	nvarchar(16),
			JobTimeTableInfoName	nvarchar(150))
					
	EXEC sp_xml_removedocument @idoc 	
	
	SELECT	
			@Adding=Adding,
			@JobTimeTableInfoPkID =JobTimeTableInfoPkID,
			@JobTimeTableInfoName =JobTimeTableInfoName 
			
						
			
	FROM #tmp

	IF @Adding=0 BEGIN
	
		exec dbo.spsmm_LastSequence_SEL 'hrmJobTimeTableInfo',@JobTimeTableInfoPkID output
		
		IF (SELECT COUNT(*) FROM hrmJobTimeTableInfo where JobTimeTableInfoPkID =@JobTimeTableInfoPkID)>0
		BEGIN
			RAISERROR('.',16,1)
			RETURN
		END
		
		INSERT INTO hrmJobTimeTableInfo 
					(	JobTimeTableInfoPkID,
						JobTimeTableInfoName )
		
		VALUES (@JobTimeTableInfoPkID,
				@JobTimeTableInfoName )
	END
	ELSE

		UPDATE hrmJobTimeTableInfo
		SET JobTimeTableInfoPkID =@JobTimeTableInfoPkID,JobTimeTableInfoName =@JobTimeTableInfoName
		WHERE JobTimeTableInfoPkID =@JobTimeTableInfoPkID
END

GO
