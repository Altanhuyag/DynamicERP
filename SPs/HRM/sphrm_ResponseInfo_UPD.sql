IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_ResponseInfo_UPD')
DROP PROC sphrm_ResponseInfo_UPD
GO
CREATE PROC sphrm_ResponseInfo_UPD
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
			@ResponseInfoPkID	nvarchar(16),
			@ResponseInfoName	nvarchar(150)				
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (  Adding				TinyInt,
			ResponseInfoPkID			nvarchar(16),
			ResponseInfoName			nvarchar(150))
	EXEC sp_xml_removedocument @idoc 
	
	SELECT	@Adding=Adding,
			@ResponseInfoPkID=ResponseInfoPkID,
			@ResponseInfoName=ResponseInfoName
	FROM #tmp   
	
	IF @Adding=0 BEGIN

		EXEC spsmm_LastSequence_SEL 'hrmResponseInfo', @ResponseInfoPkID output

		INSERT INTO hrmResponseInfo(
			ResponseInfoPkID,
			ResponseInfoName)
		VALUES (@ResponseInfoPkID,
			@ResponseInfoName)
	END
	ELSE
		UPDATE hrmResponseInfo
		SET 
			ResponseInfoPkID=@ResponseInfoPkID,
			ResponseInfoName=@ResponseInfoName

		WHERE ResponseInfoPkID=@ResponseInfoPkID
END
GO
