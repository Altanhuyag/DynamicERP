IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_DegreeInfo_DEL')
DROP PROC sphrm_DegreeInfo_DEL
GO
CREATE PROC sphrm_DegreeInfo_DEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc			INT
			
			
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH (	DegreeInfoPkID		nvarchar(20))
	EXEC sp_xml_removedocument @idoc

  
	DELETE A
	FROM hrmDegreeInfo A
		INNER JOIN #tmp B ON A.DegreeInfoPkID=B.DegreeInfoPkID
END
GO
