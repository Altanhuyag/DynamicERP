IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_SumInfo_GET')
DROP PROC sphrm_SumInfo_GET
GO
CREATE PROC sphrm_NationalityInfo_UPD
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
			@NationalityPkID		NVARCHAR(16),
			@NationalityName		NVARCHAR(255)
	
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (  Adding					TinyInt,
				NationalityPkID			NVARCHAR(16),
				NationalityName			NVARCHAR(255))
	EXEC sp_xml_removedocument @idoc 	

	
	SELECT @Adding=Adding, @NationalityPkID=NationalityPkID, @NationalityName=NationalityName FROM #tmp
   
	
	IF @Adding=0 BEGIN
	
		IF (SELECT COUNT(*) FROM hrmNationalityInfo WHERE NationalityName=@NationalityName) > 0
			BEGIN
 				RAISERROR ('Яс үндэсийн нэр давхардаж байна !', 16, 1)
				RETURN (1)
			END
		
		EXEC dbo.spsmm_LastSequence_SEL 'hrmNationalityInfo', @NationalityPkID output

		INSERT INTO hrmNationalityInfo(NationalityPkID, NationalityName)		
		VALUES (@NationalityPkID, @NationalityName) 
	END
	ELSE
		UPDATE hrmNationalityInfo
		SET NationalityName=@NationalityName
		WHERE NationalityPkID=@NationalityPkID
END
GO
