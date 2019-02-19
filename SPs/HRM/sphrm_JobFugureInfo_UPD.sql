IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_JobFugureInfo_UPD')
DROP PROC sphrm_JobFugureInfo_UPD
GO
CREATE PROC sphrm_JobFugureInfo_UPD
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
			@JobFugureInfoPkID			nvarchar(16),
			@JobFugureInfoName		nvarchar(150)
			
	
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (  Adding				TinyInt,	
			JobFugureInfoPkID	nvarchar(16),
			JobFugureInfoName		nvarchar(150))
					
	EXEC sp_xml_removedocument @idoc 	
	
	SELECT	
			@Adding=Adding,
			@JobFugureInfoPkID =JobFugureInfoPkID,
			@JobFugureInfoName =JobFugureInfoName 
			
						
			
	FROM #tmp

	IF @Adding=0 BEGIN
	
		exec dbo.spsmm_LastSequence_SEL 'worJobTypeInfo',@JobFugureInfoPkID output
		
		IF (SELECT COUNT(*) FROM hrmJobFugureInfo where JobFugureInfoPkID =@JobFugureInfoPkID)>0
		BEGIN
			RAISERROR('.',16,1)
			RETURN
		END
		
		INSERT INTO hrmJobFugureInfo 
					(	JobFugureInfoPkID,
						JobFugureInfoName )
		
		VALUES (@JobFugureInfoPkID,
				@JobFugureInfoName )
	END
	ELSE

		UPDATE hrmJobFugureInfo
		SET JobFugureInfoPkID =@JobFugureInfoPkID,JobFugureInfoName =@JobFugureInfoName
		WHERE JobFugureInfoPkID =@JobFugureInfoPkID
END

GO
