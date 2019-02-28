IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_EventInfo_UPD')
DROP PROC sphrm_EventInfo_UPD
GO
CREATE PROC sphrm_EventInfo_UPD
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
			@EventInfoPkID nvarchar(16),
			@EventInfoName nvarchar(255)
			
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (  Adding				TinyInt,
			EventInfoPkID nvarchar(16),
			EventInfoName nvarchar(255)
			)
	EXEC sp_xml_removedocument @idoc 	

	
	SELECT	@Adding=Adding,
			@EventInfoPkID=EventInfoPkID,
			@EventInfoName=EventInfoName
	FROM #tmp

	IF @Adding=0 BEGIN

		EXEC spsmm_LastSequence_SEL 'hrmEventInfo', @EventInfoPkID output

		INSERT INTO hrmEventInfo(
				EventInfoPkID ,
				EventInfoName)
		VALUES (
				@EventInfoPkID ,
				@EventInfoName)	
	END
	ELSE
		UPDATE hrmEventInfo
		SET 
			EventInfoName=@EventInfoName
			
		WHERE EventInfoPkID=@EventInfoPkID
END
GO
