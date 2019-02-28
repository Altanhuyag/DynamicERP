IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_DocumentInfo_UPD')
DROP PROC sphrm_DocumentInfo_UPD
GO
CREATE PROC sphrm_DocumentInfo_UPD
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
			@DocumentInfoPkID			nvarchar(16),
			@DocumentInfoName		nvarchar(150)
			
	
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (  Adding				TinyInt,	
			DocumentInfoPkID	nvarchar(16),
			DocumentInfoName		nvarchar(150))
					
	EXEC sp_xml_removedocument @idoc 	
	
	SELECT	
			@Adding=Adding,
			@DocumentInfoPkID =DocumentInfoPkID,
			@DocumentInfoName =DocumentInfoName 
			
						
			
	FROM #tmp

	IF @Adding=0 BEGIN
	
		exec dbo.spsmm_LastSequence_SEL 'hrmDocumentInfo',@DocumentInfoPkID output
		
		IF (SELECT COUNT(*) FROM hrmDocumentInfo where DocumentInfoPkID =@DocumentInfoPkID)>0
		BEGIN
			RAISERROR('.',16,1)
			RETURN
		END
		
		INSERT INTO hrmDocumentInfo 
					(	DocumentInfoPkID,
						DocumentInfoName )
		
		VALUES (@DocumentInfoPkID,
				@DocumentInfoName )
	END
	ELSE

		UPDATE hrmDocumentInfo
		SET DocumentInfoPkID =@DocumentInfoPkID,DocumentInfoName =@DocumentInfoName
		WHERE DocumentInfoPkID =@DocumentInfoPkID
END

GO
