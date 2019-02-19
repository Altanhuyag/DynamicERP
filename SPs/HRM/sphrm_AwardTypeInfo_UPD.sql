IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_AwardTypeInfo_UPD')
DROP PROC sphrm_AwardTypeInfo_UPD
GO
CREATE PROC sphrm_AwardTypeInfo_UPD
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc				Int,
			@Adding				TinyInt,
			@AwardTypeInfoPkID nvarchar(16),
			@AwardTypeInfoName nvarchar(255)
			
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (  Adding		  TinyInt,
			AwardTypeInfoPkID nvarchar(16),
			AwardTypeInfoName nvarchar(255)
			)
	EXEC sp_xml_removedocument @idoc 	

	
	SELECT	@Adding=Adding,
			@AwardTypeInfoPkID=AwardTypeInfoPkID,
			@AwardTypeInfoName=AwardTypeInfoName
	FROM #tmp

	IF @Adding=0 BEGIN

		EXEC spsmm_LastSequence_SEL 'hrmAwardTypeInfo', @AwardTypeInfoPkID output

		INSERT INTO hrmAwardTypeInfo(AwardTypeInfoPkID ,
				AwardTypeInfoName
				)
		VALUES (
				@AwardTypeInfoPkID,
				@AwardTypeInfoName
				)	
	END
	ELSE
		UPDATE hrmAwardTypeInfo
		SET AwardTypeInfoPkID=@AwardTypeInfoPkID,
			AwardTypeInfoName=@AwardTypeInfoName
			
		WHERE AwardTypeInfoPkID=@AwardTypeInfoPkID
END
GO
