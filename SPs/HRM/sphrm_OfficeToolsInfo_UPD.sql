IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_OfficeToolsInfo_UPD')
DROP PROC sphrm_OfficeToolsInfo_UPD
GO
CREATE PROC sphrm_OfficeToolsInfo_UPD
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
			@OfficeToolsInfoPkID	nvarchar(16),
			@OfficeToolsInfoName	nvarchar(150)				
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML

	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (  Adding				TinyInt,
			OfficeToolsInfoPkID			nvarchar(16),
			OfficeToolsInfoName			nvarchar(150))
	EXEC sp_xml_removedocument @idoc 
	
	SELECT	@Adding=Adding,
			@OfficeToolsInfoPkID=OfficeToolsInfoPkID,
			@OfficeToolsInfoName=OfficeToolsInfoName
	FROM #tmp   
	
	IF @Adding=0 BEGIN

		EXEC spsmm_LastSequence_SEL 'hrmOfficeToolsInfo', @OfficeToolsInfoPkID output

		INSERT INTO hrmOfficeToolsInfo(
			OfficeToolsInfoPkID,
			OfficeToolsInfoName)
		VALUES (@OfficeToolsInfoPkID,
			@OfficeToolsInfoName)
	END
	ELSE
		UPDATE hrmOfficeToolsInfo
		SET 
			OfficeToolsInfoPkID=@OfficeToolsInfoPkID,
			OfficeToolsInfoName=@OfficeToolsInfoName

		WHERE OfficeToolsInfoPkID=@OfficeToolsInfoPkID
END
GO
