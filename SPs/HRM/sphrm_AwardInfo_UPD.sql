IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_AwardInfo_UPD')
DROP PROC sphrm_AwardInfo_UPD
GO
CREATE PROC sphrm_AwardInfo_UPD
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
			@AwardInfoPkID nvarchar(16),
			@AwardTypeInfoPkID nvarchar(16),
			@AwardName nvarchar(255)
			
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (  Adding				TinyInt,
			AwardInfoPkID nvarchar(16),
			AwardTypeInfoPkID nvarchar(16),
			AwardName nvarchar(255)
			)
	EXEC sp_xml_removedocument @idoc 	

	
	SELECT	@Adding=Adding,
			@AwardInfoPkID=AwardInfoPkID,
			@AwardTypeInfoPkID=AwardTypeInfoPkID,
			@AwardName=AwardName
	FROM #tmp

	IF @Adding=0 BEGIN

		EXEC spsmm_LastSequence_SEL 'hrmAwardInfo', @AwardInfoPkID output

		INSERT INTO hrmAwardInfo(
				AwardInfoPkID ,
				AwardTypeInfoPkID,
				AwardName)
		VALUES (
				@AwardInfoPkID ,
				@AwardTypeInfoPkID,
				@AwardName)	
	END
	ELSE
		UPDATE hrmAwardInfo
		SET AwardInfoPkID=@AwardInfoPkID,
			AwardTypeInfoPkID=@AwardTypeInfoPkID,
			AwardName=@AwardName
			
		WHERE AwardInfoPkID=@AwardInfoPkID
END
GO
