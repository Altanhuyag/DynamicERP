IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_EducationInfo_UPD')
DROP PROC sphrm_EducationInfo_UPD
GO
CREATE PROC sphrm_EducationInfo_UPD
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
			@EducationPkID  NVARCHAR(16),
			@EducationName  NVARCHAR(255)
	
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (  Adding				TinyInt,
				EducationPkID		NVARCHAR(16),
				EducationName		NVARCHAR(255))
	EXEC sp_xml_removedocument @idoc 	

	
	SELECT @Adding=Adding, @EducationPkID=EducationPkID, @EducationName=EducationName FROM #tmp
   
	
	IF @Adding=0 BEGIN 
	
		IF (SELECT COUNT(*) FROM hrmEducationInfo WHERE EducationName=@EducationName) > 0
			BEGIN
 				RAISERROR ('Боловсролын зэргийн нэр давхардаж байна !', 16, 1)
				RETURN (1)		
			END
		
		EXEC dbo.spsmm_LastSequence_SEL 'hrmEducationInfo', @EducationPkID output

		INSERT INTO hrmEducationInfo(EducationPkID, EducationName)		
		VALUES (@EducationPkID, @EducationName) 
	END
	ELSE
		UPDATE hrmEducationInfo
		SET EducationName=@EducationName
		WHERE EducationPkID=@EducationPkID 
END


GO
