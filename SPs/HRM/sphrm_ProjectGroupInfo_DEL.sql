USE GeganetMedical
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON
GO
CREATE PROC sphrm_ProjectGroupInfo_DEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS 

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc			INT,
			@ProjectGroupInfoPkID		nvarchar(16)
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (	ProjectGroupInfoPkID		nvarchar(16))
	EXEC sp_xml_removedocument @idoc

	SELECT @ProjectGroupInfoPkID=ProjectGroupInfoPkID FROM #tmp
	
	DELETE FROM hrmProjectGroupInfo
	where ProjectGroupInfoPkID = @ProjectGroupInfoPkID
	
	END
GO
