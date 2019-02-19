IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sphrm_SkillInfo_DEL')
DROP PROC sphrm_SkillInfo_DEL
GO
CREATE PROC sphrm_SkillInfo_DEL
(
	@XML		  NVARCHAR(MAX),
    @IntResult    TINYINT		 OUTPUT,
    @StrResult    NVARCHAR(2000) OUTPUT
) WITH ENCRYPTION
AS

BEGIN
	SET NOCOUNT ON
	DECLARE @idoc				INT,
			@SkillPkID			nvarchar(16),
			@Cnt				Int,
			@Descr				nvarchar(MAX),
			@LogUserGroupID		nvarchar(16)
			
			
	EXEC sp_xml_preparedocument @idoc OUTPUT, @XML
	SELECT * INTO #tmp
		FROM OPENXML (@idoc,'//BusinessObject',2)
		WITH ( SkillPkID		nvarchar(16),
				LogUserGroupID		nvarchar(16) )
	EXEC sp_xml_removedocument @idoc 

	SELECT @SkillPkID=SkillPkID, @LogUserGroupID=LogUserGroupID FROM #tmp
	   
	DELETE A
	FROM hrmSkillInfo A
		INNER JOIN #tmp B ON A.SkillPkID=B.SkillPkID
END
GO
